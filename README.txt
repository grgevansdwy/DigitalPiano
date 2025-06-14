These files are for testing Lab 4 functionality for EE 469
By: Victor Marcenac, Summer 2024

Required Instructions:
ADDI, ADDS, SUBS, B, CBZ, B.LT, BR, BL


Individual Tests:
// Expected Results: 			// (each worth 12 points)
// X0 = 123				// ADDI
// X1 = 2345				// ADDI (zero extended)
// X2 = 2020				// LDUR & STUR (worth 36 points)
// X3 = 3				// B
// X4 = 4				// CBZ
// X5 = -5				// SUBS
// X6 = 6				// ADDS
// X7 = 7				// B.LT
// X8 = 8				// BR
// X9 = 9				// BR (fwding)
// X10 = 10				// B.LT delay
// X11 = 11				// Not FWDing (instruction)
// X12 = 12				// BL
// X13 = 13				// FWDing
// X14 = 14				// Not FWDing (X31)


Full Test:
// Expected Results: 			// (each worth 12 points)
// X0 = 123				// ADDI
// X1 = 2345				// ADDI (zero extended)
// X2 = 2020				// LDUR & STUR (worth 36 points)
// X3 = 3				// B
// X4 = 4				// CBZ
// X5 = -5				// SUBS
// X6 = 6				// ADDS
// X7 = 7				// B.LT
// X8 = 8				// BR
// X9 = 9				// BR (fwding)
// X10 = 10				// B.LT delay
// X11 = 11				// Not FWDing (instruction)
// X12 = 1012				// BL
// X13 = 13				// FWDing
// X14 = 14				// Not FWDing (X31)
