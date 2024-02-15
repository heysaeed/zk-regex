const circom_tester = require("circom_tester");
const wasm_tester = circom_tester.wasm;
import * as path from "path";
const apis = require("../../apis");
const option = {
  include: path.join(__dirname, "../../../node_modules"),
};
const compiler = require("../../compiler");

jest.setTimeout(120000);
describe("Email Address Regex", () => {
  let circuit;
  beforeAll(async () => {
    compiler.genFromDecomposed(
      path.join(__dirname, "../circuits/common/email_addr.json"),
      {
        circomFilePath: path.join(
          __dirname,
          "../circuits/common/email_addr_regex.circom"
        ),
        templateName: "EmailAddrRegex",
        genSubstrs: true,
      }
    );
    circuit = await wasm_tester(
      path.join(__dirname, "./circuits/test_email_addr_regex.circom"),
      option
    );
  });

  it("only an email address", async () => {
    const emailAddr = "suegamisora@gmail.com";
    const paddedStr = apis.padString(emailAddr, 256);
    const circuitInputs = {
      msg: paddedStr,
    };
    const witness = await circuit.calculateWitness(circuitInputs);
    await circuit.checkConstraints(witness);
    expect(1n).toEqual(witness[1]);
    const prefixIdxes = apis.extractEmailAddrIdxes(emailAddr)[0];
    for (let idx = 0; idx < 256; ++idx) {
      if (idx >= prefixIdxes[0] && idx < prefixIdxes[1]) {
        expect(BigInt(paddedStr[idx])).toEqual(witness[2 + idx]);
      } else {
        expect(0n).toEqual(witness[2 + idx]);
      }
    }
  });

  it("with a prefix", async () => {
    const prefix = "subject:";
    const emailAddr = "suegamisora@gmail.com";
    const string = prefix + emailAddr;
    const paddedStr = apis.padString(string, 256);
    const circuitInputs = {
      msg: paddedStr,
    };
    const witness = await circuit.calculateWitness(circuitInputs);
    await circuit.checkConstraints(witness);
    expect(1n).toEqual(witness[1]);
    const prefixIdxes = apis.extractEmailAddrIdxes(string)[0];
    for (let idx = 0; idx < 256; ++idx) {
      if (idx >= prefixIdxes[0] && idx < prefixIdxes[1]) {
        expect(BigInt(paddedStr[idx])).toEqual(witness[2 + idx]);
      } else {
        expect(0n).toEqual(witness[2 + idx]);
      }
    }
  });
});