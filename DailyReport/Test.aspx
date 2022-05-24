<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="DailyReport.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body >
       <form id="contact"  runat="server">
    <div class="shadow-lg p-3 mb-5 bg-white rounded">

        <div class="row">
                    <div class="col-sm-1">
                        <asp:Label CssClass="form-control"  runat="server" ID="lblArea" Text="Area"></asp:Label>
                        
                    </div>
                   <div class="col-sm-3">
                       <asp:TextBox CssClass="form-control" ID="txtarea" runat="server"></asp:TextBox>
                   </div>
                    <div class="col-sm-3">
                        <asp:Button ID="btnsave" CssClass="btn btn-success" runat="server" Text="Save" />
                        <asp:Label ID="lblerror" runat="server" ForeColor="Red"> </asp:Label>
                    </div>
                    
                </div>



        </div>
           </form>
</body>
</html>
