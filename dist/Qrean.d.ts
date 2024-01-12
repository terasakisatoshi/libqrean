export declare const setText: (mem: Uint8ClampedArray, idx: number, s: string) => void;
export declare const getText: (mem: Uint8ClampedArray, idx: number) => string;
type MakeOptions = {
    code_type?: keyof typeof Qrean.CODE_TYPES;
    data_type?: keyof typeof Qrean.DATA_TYPES;
    qr_version?: keyof typeof Qrean.QR_VERSIONS;
    qr_maskpattern?: keyof typeof Qrean.QR_MASKPATTERNS;
    qr_errorlevel?: keyof typeof Qrean.QR_ERRORLEVELS;
    scale?: number;
    padding?: number;
};
type DetectOptions = {
    gamma?: number;
    digitized?: Uint8ClampedArray;
    eci_code?: 'UTF-8' | 'ShiftJIS' | 'Latin1';
};
export declare class Qrean {
    wasm: WebAssembly.WebAssemblyInstantiatedSource;
    on_found?: (type: string, str: string) => void;
    static create(debug?: boolean): Promise<Qrean>;
    private constructor();
    static CODE_TYPE_QR: "QR";
    static CODE_TYPE_MQR: "mQR";
    static CODE_TYPE_RMQR: "rMQR";
    static CODE_TYPE_TQR: "tQR";
    static CODE_TYPE_EAN13: "EAN13";
    static CODE_TYPE_EAN8: "EAN8";
    static CODE_TYPE_UPCA: "UPCA";
    static CODE_TYPE_CODE39: "CODE39";
    static CODE_TYPE_CODE93: "CODE93";
    static CODE_TYPE_NW7: "NW7";
    static CODE_TYPE_ITF: "ITF";
    static CODE_TYPES: {
        QR: 1;
        mQR: 2;
        rMQR: 3;
        tQR: 4;
        EAN13: 5;
        EAN8: 6;
        UPCA: 7;
        CODE39: 8;
        CODE93: 9;
        NW7: 10;
        ITF: 11;
    };
    static DATA_TYPE_AUTO: "AUTO";
    static DATA_TYPE_NUMERIC: "NUMERIC";
    static DATA_TYPE_ALNUM: "ALNUM";
    static DATA_TYPE_8BIT: "8BIT";
    static DATA_TYPE_KANJI: "KANJI";
    static DATA_TYPES: {
        AUTO: 0;
        NUMERIC: 1;
        ALNUM: 2;
        "8BIT": 3;
        KANJI: 4;
    };
    static QR_VERSION_AUTO: "AUTO";
    static QR_VERSION_1: "1";
    static QR_VERSION_2: "2";
    static QR_VERSION_3: "3";
    static QR_VERSION_4: "4";
    static QR_VERSION_5: "5";
    static QR_VERSION_6: "6";
    static QR_VERSION_7: "7";
    static QR_VERSION_8: "8";
    static QR_VERSION_9: "9";
    static QR_VERSION_10: "10";
    static QR_VERSION_11: "11";
    static QR_VERSION_12: "12";
    static QR_VERSION_13: "13";
    static QR_VERSION_14: "14";
    static QR_VERSION_15: "15";
    static QR_VERSION_16: "16";
    static QR_VERSION_17: "17";
    static QR_VERSION_18: "18";
    static QR_VERSION_19: "19";
    static QR_VERSION_20: "20";
    static QR_VERSION_21: "21";
    static QR_VERSION_22: "22";
    static QR_VERSION_23: "23";
    static QR_VERSION_24: "24";
    static QR_VERSION_25: "25";
    static QR_VERSION_26: "26";
    static QR_VERSION_27: "27";
    static QR_VERSION_28: "28";
    static QR_VERSION_29: "29";
    static QR_VERSION_30: "30";
    static QR_VERSION_31: "31";
    static QR_VERSION_32: "32";
    static QR_VERSION_33: "33";
    static QR_VERSION_34: "34";
    static QR_VERSION_35: "35";
    static QR_VERSION_36: "36";
    static QR_VERSION_37: "37";
    static QR_VERSION_38: "38";
    static QR_VERSION_39: "39";
    static QR_VERSION_40: "40";
    static QR_VERSION_M1: "M1";
    static QR_VERSION_M2: "M2";
    static QR_VERSION_M3: "M3";
    static QR_VERSION_M4: "M4";
    static QR_VERSION_R7x43: "R7x43";
    static QR_VERSION_R7x59: "R7x59";
    static QR_VERSION_R7x77: "R7x77";
    static QR_VERSION_R7x99: "R7x99";
    static QR_VERSION_R7x139: "R7x139";
    static QR_VERSION_R9x43: "R9x43";
    static QR_VERSION_R9x59: "R9x59";
    static QR_VERSION_R9x77: "R9x77";
    static QR_VERSION_R9x99: "R9x99";
    static QR_VERSION_R9x139: "R9x139";
    static QR_VERSION_R11x27: "R11x27";
    static QR_VERSION_R11x43: "R11x43";
    static QR_VERSION_R11x59: "R11x59";
    static QR_VERSION_R11x77: "R11x77";
    static QR_VERSION_R11x99: "R11x99";
    static QR_VERSION_R11x139: "R11x139";
    static QR_VERSION_R13x27: "R13x27";
    static QR_VERSION_R13x43: "R13x43";
    static QR_VERSION_R13x59: "R13x59";
    static QR_VERSION_R13x77: "R13x77";
    static QR_VERSION_R13x99: "R13x99";
    static QR_VERSION_R13x139: "R13x139";
    static QR_VERSION_R15x43: "R15x43";
    static QR_VERSION_R15x59: "R15x59";
    static QR_VERSION_R15x77: "R15x77";
    static QR_VERSION_R15x99: "R15x99";
    static QR_VERSION_R15x139: "R15x139";
    static QR_VERSION_R17x43: "R17x43";
    static QR_VERSION_R17x59: "R17x59";
    static QR_VERSION_R17x77: "R17x77";
    static QR_VERSION_R17x99: "R17x99";
    static QR_VERSION_R17x139: "R17x139";
    static QR_VERSION_TQR: "TQR";
    static QR_VERSIONS: {
        AUTO: 0;
        "1": 1;
        "2": 2;
        "3": 3;
        "4": 4;
        "5": 5;
        "6": 6;
        "7": 7;
        "8": 8;
        "9": 9;
        "10": 10;
        "11": 11;
        "12": 12;
        "13": 13;
        "14": 14;
        "15": 15;
        "16": 16;
        "17": 17;
        "18": 18;
        "19": 19;
        "20": 20;
        "21": 21;
        "22": 22;
        "23": 23;
        "24": 24;
        "25": 25;
        "26": 26;
        "27": 27;
        "28": 28;
        "29": 29;
        "30": 30;
        "31": 31;
        "32": 32;
        "33": 33;
        "34": 34;
        "35": 35;
        "36": 36;
        "37": 37;
        "38": 38;
        "39": 39;
        "40": 40;
        M1: 41;
        M2: 42;
        M3: 43;
        M4: 44;
        R7x43: 45;
        R7x59: 46;
        R7x77: 47;
        R7x99: 48;
        R7x139: 49;
        R9x43: 50;
        R9x59: 51;
        R9x77: 52;
        R9x99: 53;
        R9x139: 54;
        R11x27: 55;
        R11x43: 56;
        R11x59: 57;
        R11x77: 58;
        R11x99: 59;
        R11x139: 60;
        R13x27: 61;
        R13x43: 62;
        R13x59: 63;
        R13x77: 64;
        R13x99: 65;
        R13x139: 66;
        R15x43: 67;
        R15x59: 68;
        R15x77: 69;
        R15x99: 70;
        R15x139: 71;
        R17x43: 72;
        R17x59: 73;
        R17x77: 74;
        R17x99: 75;
        R17x139: 76;
        TQR: 77;
    };
    static QR_ERRORLEVEL_L: "L";
    static QR_ERRORLEVEL_M: "M";
    static QR_ERRORLEVEL_Q: "Q";
    static QR_ERRORLEVEL_H: "H";
    static QR_ERRORLEVELS: {
        L: 0;
        M: 1;
        Q: 2;
        H: 3;
    };
    static QR_MASKPATTERN_0: "0";
    static QR_MASKPATTERN_1: "1";
    static QR_MASKPATTERN_2: "2";
    static QR_MASKPATTERN_3: "3";
    static QR_MASKPATTERN_4: "4";
    static QR_MASKPATTERN_5: "5";
    static QR_MASKPATTERN_6: "6";
    static QR_MASKPATTERN_7: "7";
    static QR_MASKPATTERN_AUTO: "AUTO";
    static QR_MASKPATTERNS: {
        "0": 0;
        "1": 1;
        "2": 2;
        "3": 3;
        "4": 4;
        "5": 5;
        "6": 6;
        "7": 7;
        AUTO: 10;
    };
    static QR_ECI_CODE_LATIN1: "Latin1";
    static QR_ECI_CODE_SJIS: "ShiftJIS";
    static QR_ECI_CODE_UTF8: "UTF-8";
    static QR_ECI_CODES: {
        Latin1: 3;
        ShiftJIS: 20;
        "UTF-8": 26;
    };
    make(text: string, opts?: MakeOptions | keyof typeof Qrean.CODE_TYPES): ImageData;
    detect(imgdata: ImageData, callback: (type: string, str: string) => void, opts?: DetectOptions): any;
}
export {};
