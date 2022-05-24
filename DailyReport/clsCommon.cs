using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace DailyReport
{
    public class clsCommon
    {

        public string Connectionstring()
        {
            string connStr = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;

            return connStr;
        }


        public DataTable bindTransaction(int companyid,int isincome )
        {
            string connStr = Connectionstring();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("GetTransaction", conn);
            cmd.Parameters.AddWithValue("@Company", Convert.ToInt32(companyid));
            cmd.Parameters.AddWithValue("@Isincome", isincome);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            return dt;

        }
        public DataTable getmenu( int Userid)
        {

            string connStr = Connectionstring();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Getmenu", conn);
            cmd.Parameters.Add("@userid", Userid);
          

            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }

        public DataTable getimages(int Userid)
        {

            string connStr = Connectionstring();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("getimages", conn);
            cmd.Parameters.Add("@userid", Userid);


            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }

        public DataTable getItembydocid(int docid)
        {

            string connStr = Connectionstring();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("GetItembyDocid", conn);
            cmd.Parameters.Add("@docid", docid);


            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }


    }



}