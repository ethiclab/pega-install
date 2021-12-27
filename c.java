import java.sql.DriverManager;

public class c {
        public static void main(String[] args) throws Exception {
                System.out.println("begin");
                c.class.getClassLoader().loadClass("org.postgresql.Driver");
                DriverManager.getConnection("jdbc:postgresql://192.168.10.202:5432/pegadb", "baseuser", "password");
                System.out.println("end");
        }
}
