using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Healthcare_Analysis_CrystalReport
{
    class Configuration
    {
        String ConnectionStr = @"Data Source=TAYYABA;Initial Catalog=FinalWithData;Integrated Security=True";

        SqlConnection con;
        private static Configuration _instance;
        public static Configuration getInstance()
        {
            if (_instance == null)
                _instance = new Configuration();
            return _instance;
        }
        private Configuration()
        {
            con = new SqlConnection(ConnectionStr);
            con.Open();
            try
            {

                Console.WriteLine("Connected to the database successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error connecting to the database: {ex.Message}");
                throw; // Rethrow the exception to indicate a failure in the connection process
            }
        }
        public SqlConnection getConnection()
        {
            return con;
        }
    }
}






