pragma circom 2.1.5;

include "@zk-email/zk-regex-circom/circuits/regex_helpers.circom";

// regex: ((\n)|^)dkim-signature:((a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z)+=[^;]+; )+t=(0|1|2|3|4|5|6|7|8|9)+;
template TimestampRegex(msg_bytes) {
	signal input msg[msg_bytes];
	signal output out;

	var num_bytes = msg_bytes+1;
	signal in[num_bytes];
	in[0]<==255;
	for (var i = 0; i < msg_bytes; i++) {
		in[i+1] <== msg[i];
	}

	component eq[35][num_bytes];
	component lt[10][num_bytes];
	component and[41][num_bytes];
	component multi_or[10][num_bytes];
	signal states[num_bytes+1][27];
	component state_changed[num_bytes];

	states[0][0] <== 1;
	for (var i = 1; i < 27; i++) {
		states[0][i] <== 0;
	}

	for (var i = 0; i < num_bytes; i++) {
		state_changed[i] = MultiOR(26);
		lt[0][i] = LessEqThan(8);
		lt[0][i].in[0] <== 97;
		lt[0][i].in[1] <== in[i];
		lt[1][i] = LessEqThan(8);
		lt[1][i].in[0] <== in[i];
		lt[1][i].in[1] <== 122;
		and[0][i] = AND();
		and[0][i].a <== lt[0][i].out;
		and[0][i].b <== lt[1][i].out;
		and[1][i] = AND();
		and[1][i].a <== states[i][1];
		and[1][i].b <== and[0][i].out;
		lt[2][i] = LessEqThan(8);
		lt[2][i].in[0] <== 97;
		lt[2][i].in[1] <== in[i];
		lt[3][i] = LessEqThan(8);
		lt[3][i].in[0] <== in[i];
		lt[3][i].in[1] <== 115;
		and[2][i] = AND();
		and[2][i].a <== lt[2][i].out;
		and[2][i].b <== lt[3][i].out;
		eq[0][i] = IsEqual();
		eq[0][i].in[0] <== in[i];
		eq[0][i].in[1] <== 117;
		eq[1][i] = IsEqual();
		eq[1][i].in[0] <== in[i];
		eq[1][i].in[1] <== 118;
		eq[2][i] = IsEqual();
		eq[2][i].in[0] <== in[i];
		eq[2][i].in[1] <== 119;
		eq[3][i] = IsEqual();
		eq[3][i].in[0] <== in[i];
		eq[3][i].in[1] <== 120;
		eq[4][i] = IsEqual();
		eq[4][i].in[0] <== in[i];
		eq[4][i].in[1] <== 121;
		eq[5][i] = IsEqual();
		eq[5][i].in[0] <== in[i];
		eq[5][i].in[1] <== 122;
		and[3][i] = AND();
		and[3][i].a <== states[i][6];
		multi_or[0][i] = MultiOR(7);
		multi_or[0][i].in[0] <== and[2][i].out;
		multi_or[0][i].in[1] <== eq[0][i].out;
		multi_or[0][i].in[2] <== eq[1][i].out;
		multi_or[0][i].in[3] <== eq[2][i].out;
		multi_or[0][i].in[4] <== eq[3][i].out;
		multi_or[0][i].in[5] <== eq[4][i].out;
		multi_or[0][i].in[6] <== eq[5][i].out;
		and[3][i].b <== multi_or[0][i].out;
		and[4][i] = AND();
		and[4][i].a <== states[i][24];
		and[4][i].b <== and[0][i].out;
		and[5][i] = AND();
		and[5][i].a <== states[i][25];
		and[5][i].b <== and[0][i].out;
		multi_or[1][i] = MultiOR(4);
		multi_or[1][i].in[0] <== and[1][i].out;
		multi_or[1][i].in[1] <== and[3][i].out;
		multi_or[1][i].in[2] <== and[4][i].out;
		multi_or[1][i].in[3] <== and[5][i].out;
		states[i+1][1] <== multi_or[1][i].out;
		state_changed[i].in[0] <== states[i+1][1];
		lt[4][i] = LessEqThan(8);
		lt[4][i].in[0] <== 0;
		lt[4][i].in[1] <== in[i];
		lt[5][i] = LessEqThan(8);
		lt[5][i].in[0] <== in[i];
		lt[5][i].in[1] <== 58;
		and[6][i] = AND();
		and[6][i].a <== lt[4][i].out;
		and[6][i].b <== lt[5][i].out;
		lt[6][i] = LessEqThan(8);
		lt[6][i].in[0] <== 60;
		lt[6][i].in[1] <== in[i];
		lt[7][i] = LessEqThan(8);
		lt[7][i].in[0] <== in[i];
		lt[7][i].in[1] <== 254;
		and[7][i] = AND();
		and[7][i].a <== lt[6][i].out;
		and[7][i].b <== lt[7][i].out;
		and[8][i] = AND();
		and[8][i].a <== states[i][2];
		multi_or[2][i] = MultiOR(2);
		multi_or[2][i].in[0] <== and[6][i].out;
		multi_or[2][i].in[1] <== and[7][i].out;
		and[8][i].b <== multi_or[2][i].out;
		lt[8][i] = LessEqThan(8);
		lt[8][i].in[0] <== 0;
		lt[8][i].in[1] <== in[i];
		lt[9][i] = LessEqThan(8);
		lt[9][i].in[0] <== in[i];
		lt[9][i].in[1] <== 47;
		and[9][i] = AND();
		and[9][i].a <== lt[8][i].out;
		and[9][i].b <== lt[9][i].out;
		eq[6][i] = IsEqual();
		eq[6][i].in[0] <== in[i];
		eq[6][i].in[1] <== 58;
		and[10][i] = AND();
		and[10][i].a <== states[i][3];
		multi_or[3][i] = MultiOR(3);
		multi_or[3][i].in[0] <== and[9][i].out;
		multi_or[3][i].in[1] <== and[7][i].out;
		multi_or[3][i].in[2] <== eq[6][i].out;
		and[10][i].b <== multi_or[3][i].out;
		and[11][i] = AND();
		and[11][i].a <== states[i][7];
		and[11][i].b <== multi_or[2][i].out;
		and[12][i] = AND();
		and[12][i].a <== states[i][26];
		and[12][i].b <== multi_or[3][i].out;
		multi_or[4][i] = MultiOR(4);
		multi_or[4][i].in[0] <== and[8][i].out;
		multi_or[4][i].in[1] <== and[10][i].out;
		multi_or[4][i].in[2] <== and[11][i].out;
		multi_or[4][i].in[3] <== and[12][i].out;
		states[i+1][2] <== multi_or[4][i].out;
		state_changed[i].in[1] <== states[i+1][2];
		eq[7][i] = IsEqual();
		eq[7][i].in[0] <== in[i];
		eq[7][i].in[1] <== 48;
		eq[8][i] = IsEqual();
		eq[8][i].in[0] <== in[i];
		eq[8][i].in[1] <== 49;
		eq[9][i] = IsEqual();
		eq[9][i].in[0] <== in[i];
		eq[9][i].in[1] <== 50;
		eq[10][i] = IsEqual();
		eq[10][i].in[0] <== in[i];
		eq[10][i].in[1] <== 51;
		eq[11][i] = IsEqual();
		eq[11][i].in[0] <== in[i];
		eq[11][i].in[1] <== 52;
		eq[12][i] = IsEqual();
		eq[12][i].in[0] <== in[i];
		eq[12][i].in[1] <== 53;
		eq[13][i] = IsEqual();
		eq[13][i].in[0] <== in[i];
		eq[13][i].in[1] <== 54;
		eq[14][i] = IsEqual();
		eq[14][i].in[0] <== in[i];
		eq[14][i].in[1] <== 55;
		eq[15][i] = IsEqual();
		eq[15][i].in[0] <== in[i];
		eq[15][i].in[1] <== 56;
		eq[16][i] = IsEqual();
		eq[16][i].in[0] <== in[i];
		eq[16][i].in[1] <== 57;
		and[13][i] = AND();
		and[13][i].a <== states[i][3];
		multi_or[5][i] = MultiOR(10);
		multi_or[5][i].in[0] <== eq[7][i].out;
		multi_or[5][i].in[1] <== eq[8][i].out;
		multi_or[5][i].in[2] <== eq[9][i].out;
		multi_or[5][i].in[3] <== eq[10][i].out;
		multi_or[5][i].in[4] <== eq[11][i].out;
		multi_or[5][i].in[5] <== eq[12][i].out;
		multi_or[5][i].in[6] <== eq[13][i].out;
		multi_or[5][i].in[7] <== eq[14][i].out;
		multi_or[5][i].in[8] <== eq[15][i].out;
		multi_or[5][i].in[9] <== eq[16][i].out;
		and[13][i].b <== multi_or[5][i].out;
		and[14][i] = AND();
		and[14][i].a <== states[i][26];
		and[14][i].b <== multi_or[5][i].out;
		multi_or[6][i] = MultiOR(2);
		multi_or[6][i].in[0] <== and[13][i].out;
		multi_or[6][i].in[1] <== and[14][i].out;
		states[i+1][3] <== multi_or[6][i].out;
		state_changed[i].in[2] <== states[i+1][3];
		eq[17][i] = IsEqual();
		eq[17][i].in[0] <== in[i];
		eq[17][i].in[1] <== 59;
		and[15][i] = AND();
		and[15][i].a <== states[i][2];
		and[15][i].b <== eq[17][i].out;
		states[i+1][4] <== and[15][i].out;
		state_changed[i].in[3] <== states[i+1][4];
		and[16][i] = AND();
		and[16][i].a <== states[i][3];
		and[16][i].b <== eq[17][i].out;
		states[i+1][5] <== and[16][i].out;
		state_changed[i].in[4] <== states[i+1][5];
		eq[18][i] = IsEqual();
		eq[18][i].in[0] <== in[i];
		eq[18][i].in[1] <== 32;
		and[17][i] = AND();
		and[17][i].a <== states[i][4];
		and[17][i].b <== eq[18][i].out;
		and[18][i] = AND();
		and[18][i].a <== states[i][5];
		and[18][i].b <== eq[18][i].out;
		multi_or[7][i] = MultiOR(2);
		multi_or[7][i].in[0] <== and[17][i].out;
		multi_or[7][i].in[1] <== and[18][i].out;
		states[i+1][6] <== multi_or[7][i].out;
		state_changed[i].in[5] <== states[i+1][6];
		eq[19][i] = IsEqual();
		eq[19][i].in[0] <== in[i];
		eq[19][i].in[1] <== 61;
		and[19][i] = AND();
		and[19][i].a <== states[i][1];
		and[19][i].b <== eq[19][i].out;
		states[i+1][7] <== and[19][i].out;
		state_changed[i].in[6] <== states[i+1][7];
		eq[20][i] = IsEqual();
		eq[20][i].in[0] <== in[i];
		eq[20][i].in[1] <== 13;
		and[20][i] = AND();
		and[20][i].a <== states[i][0];
		and[20][i].b <== eq[20][i].out;
		and[21][i] = AND();
		and[21][i].a <== states[i][9];
		and[21][i].b <== eq[20][i].out;
		multi_or[8][i] = MultiOR(2);
		multi_or[8][i].in[0] <== and[20][i].out;
		multi_or[8][i].in[1] <== and[21][i].out;
		states[i+1][8] <== multi_or[8][i].out;
		state_changed[i].in[7] <== states[i+1][8];
		eq[21][i] = IsEqual();
		eq[21][i].in[0] <== in[i];
		eq[21][i].in[1] <== 255;
		and[22][i] = AND();
		and[22][i].a <== states[i][0];
		and[22][i].b <== eq[21][i].out;
		eq[22][i] = IsEqual();
		eq[22][i].in[0] <== in[i];
		eq[22][i].in[1] <== 10;
		and[23][i] = AND();
		and[23][i].a <== states[i][8];
		and[23][i].b <== eq[22][i].out;
		multi_or[9][i] = MultiOR(2);
		multi_or[9][i].in[0] <== and[22][i].out;
		multi_or[9][i].in[1] <== and[23][i].out;
		states[i+1][9] <== multi_or[9][i].out;
		state_changed[i].in[8] <== states[i+1][9];
		eq[23][i] = IsEqual();
		eq[23][i].in[0] <== in[i];
		eq[23][i].in[1] <== 100;
		and[24][i] = AND();
		and[24][i].a <== states[i][9];
		and[24][i].b <== eq[23][i].out;
		states[i+1][10] <== and[24][i].out;
		state_changed[i].in[9] <== states[i+1][10];
		eq[24][i] = IsEqual();
		eq[24][i].in[0] <== in[i];
		eq[24][i].in[1] <== 107;
		and[25][i] = AND();
		and[25][i].a <== states[i][10];
		and[25][i].b <== eq[24][i].out;
		states[i+1][11] <== and[25][i].out;
		state_changed[i].in[10] <== states[i+1][11];
		eq[25][i] = IsEqual();
		eq[25][i].in[0] <== in[i];
		eq[25][i].in[1] <== 105;
		and[26][i] = AND();
		and[26][i].a <== states[i][11];
		and[26][i].b <== eq[25][i].out;
		states[i+1][12] <== and[26][i].out;
		state_changed[i].in[11] <== states[i+1][12];
		eq[26][i] = IsEqual();
		eq[26][i].in[0] <== in[i];
		eq[26][i].in[1] <== 109;
		and[27][i] = AND();
		and[27][i].a <== states[i][12];
		and[27][i].b <== eq[26][i].out;
		states[i+1][13] <== and[27][i].out;
		state_changed[i].in[12] <== states[i+1][13];
		eq[27][i] = IsEqual();
		eq[27][i].in[0] <== in[i];
		eq[27][i].in[1] <== 45;
		and[28][i] = AND();
		and[28][i].a <== states[i][13];
		and[28][i].b <== eq[27][i].out;
		states[i+1][14] <== and[28][i].out;
		state_changed[i].in[13] <== states[i+1][14];
		eq[28][i] = IsEqual();
		eq[28][i].in[0] <== in[i];
		eq[28][i].in[1] <== 115;
		and[29][i] = AND();
		and[29][i].a <== states[i][14];
		and[29][i].b <== eq[28][i].out;
		states[i+1][15] <== and[29][i].out;
		state_changed[i].in[14] <== states[i+1][15];
		and[30][i] = AND();
		and[30][i].a <== states[i][15];
		and[30][i].b <== eq[25][i].out;
		states[i+1][16] <== and[30][i].out;
		state_changed[i].in[15] <== states[i+1][16];
		eq[29][i] = IsEqual();
		eq[29][i].in[0] <== in[i];
		eq[29][i].in[1] <== 103;
		and[31][i] = AND();
		and[31][i].a <== states[i][16];
		and[31][i].b <== eq[29][i].out;
		states[i+1][17] <== and[31][i].out;
		state_changed[i].in[16] <== states[i+1][17];
		eq[30][i] = IsEqual();
		eq[30][i].in[0] <== in[i];
		eq[30][i].in[1] <== 110;
		and[32][i] = AND();
		and[32][i].a <== states[i][17];
		and[32][i].b <== eq[30][i].out;
		states[i+1][18] <== and[32][i].out;
		state_changed[i].in[17] <== states[i+1][18];
		eq[31][i] = IsEqual();
		eq[31][i].in[0] <== in[i];
		eq[31][i].in[1] <== 97;
		and[33][i] = AND();
		and[33][i].a <== states[i][18];
		and[33][i].b <== eq[31][i].out;
		states[i+1][19] <== and[33][i].out;
		state_changed[i].in[18] <== states[i+1][19];
		eq[32][i] = IsEqual();
		eq[32][i].in[0] <== in[i];
		eq[32][i].in[1] <== 116;
		and[34][i] = AND();
		and[34][i].a <== states[i][19];
		and[34][i].b <== eq[32][i].out;
		states[i+1][20] <== and[34][i].out;
		state_changed[i].in[19] <== states[i+1][20];
		and[35][i] = AND();
		and[35][i].a <== states[i][20];
		and[35][i].b <== eq[0][i].out;
		states[i+1][21] <== and[35][i].out;
		state_changed[i].in[20] <== states[i+1][21];
		eq[33][i] = IsEqual();
		eq[33][i].in[0] <== in[i];
		eq[33][i].in[1] <== 114;
		and[36][i] = AND();
		and[36][i].a <== states[i][21];
		and[36][i].b <== eq[33][i].out;
		states[i+1][22] <== and[36][i].out;
		state_changed[i].in[21] <== states[i+1][22];
		eq[34][i] = IsEqual();
		eq[34][i].in[0] <== in[i];
		eq[34][i].in[1] <== 101;
		and[37][i] = AND();
		and[37][i].a <== states[i][22];
		and[37][i].b <== eq[34][i].out;
		states[i+1][23] <== and[37][i].out;
		state_changed[i].in[22] <== states[i+1][23];
		and[38][i] = AND();
		and[38][i].a <== states[i][23];
		and[38][i].b <== eq[6][i].out;
		states[i+1][24] <== and[38][i].out;
		state_changed[i].in[23] <== states[i+1][24];
		and[39][i] = AND();
		and[39][i].a <== states[i][6];
		and[39][i].b <== eq[32][i].out;
		states[i+1][25] <== and[39][i].out;
		state_changed[i].in[24] <== states[i+1][25];
		and[40][i] = AND();
		and[40][i].a <== states[i][25];
		and[40][i].b <== eq[19][i].out;
		states[i+1][26] <== and[40][i].out;
		state_changed[i].in[25] <== states[i+1][26];
		states[i+1][0] <== 1 - state_changed[i].out;
	}

	component final_state_result = MultiOR(num_bytes+1);
	for (var i = 0; i <= num_bytes; i++) {
		final_state_result.in[i] <== states[i][5];
	}
	out <== final_state_result.out;

	signal is_consecutive[msg_bytes+1][2];
	is_consecutive[msg_bytes][1] <== 1;
	for (var i = 0; i < msg_bytes; i++) {
		is_consecutive[msg_bytes-1-i][0] <== states[num_bytes-i][5] * (1 - is_consecutive[msg_bytes-i][1]) + is_consecutive[msg_bytes-i][1];
		is_consecutive[msg_bytes-1-i][1] <== state_changed[msg_bytes-i].out * is_consecutive[msg_bytes-1-i][0];
	}
	signal is_substr0[msg_bytes][3];
	signal is_reveal0[msg_bytes];
	signal output reveal0[msg_bytes];
	for (var i = 0; i < msg_bytes; i++) {
		is_substr0[i][0] <== 0;
		 // the 0-th substring transitions: [(3, 3), (26, 3)]
		is_substr0[i][1] <== is_substr0[i][0] + states[i+1][3] * states[i+2][3];
		is_substr0[i][2] <== is_substr0[i][1] + states[i+1][26] * states[i+2][3];
		is_reveal0[i] <== is_substr0[i][2] * is_consecutive[i][1];
		reveal0[i] <== in[i+1] * is_reveal0[i];
	}
}