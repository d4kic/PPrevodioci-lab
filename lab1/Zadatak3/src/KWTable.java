import java.util.Hashtable;

public class KWTable {
    private Hashtable<String, Integer> mTable;

    public KWTable() {
        mTable = new Hashtable<String, Integer>();
        mTable.put("program", sym.PROGRAM);
        mTable.put("return", sym.RETURN);
        mTable.put("begin", sym.BEGIN);
        mTable.put("end", sym.END);
        mTable.put("integer", sym.INTEGER);
        mTable.put("char", sym.CHAR);
        mTable.put("string", sym.STRING);
        mTable.put("file", sym.FILE);
        mTable.put("open", sym.OPEN);
        mTable.put("read", sym.READ);
        mTable.put("in", sym.IN);
        mTable.put("do", sym.DO);
    }

    public int find(String word) {
        Integer code = mTable.get(word);
        return (code == null) ? sym.ID : code;
    }
}

