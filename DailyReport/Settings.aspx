<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="DailyReport.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="card col d-flex justify-content-center">
  <div class="card-header text-black bg-danger">
   Settings
  </div>
  <div class="card-body text-black bg-light" >
           
    <div class="row">
         <asp:Label ID="lblError" runat="server"></asp:Label>  
        <div class="col-sm-3">
         <asp:DropDownList ID="ddlimg" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Menu Card</asp:ListItem>
           <asp:ListItem Value="1">Offer 1</asp:ListItem>
            <asp:ListItem Value="2">Offer 2</asp:ListItem>
            <asp:ListItem Value="3">Offer 3</asp:ListItem>
        </asp:DropDownList>
            </div>
         <div class="col-sm-3">
        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />  
 </div>
         <div class="col-sm-3">
         <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" CssClass="btn btn-danger" /> 
          

       </div>
        </div>
        <br />
        <div class="row">
              Offer 1  <asp:Image ID="img1"  runat="server" Height="100px" Width="100px"/>  
         Offer 2 <asp:Image ID="img2"  runat="server" Height="100px" Width="100px"/>  
        Offer 3 <asp:Image ID="img3"  runat="server" Height="100px" Width="100px"/>  
   
        </div>
      
       
    
       <div class="row">
           <div class="col-sm-3"></div>
           <div>
          <asp:CheckBoxList ID="chkmenu" runat="server" CssClass="accordion">
              <asp:ListItem Text="Area"></asp:ListItem>
                  <asp:ListItem Text="ItemMaster"></asp:ListItem>
                  <asp:ListItem Text="Customer"></asp:ListItem>
              
              <asp:ListItem Text="Income"></asp:ListItem>
               <asp:ListItem Text="Expances"></asp:ListItem>
          </asp:CheckBoxList>
               <asp:TextBox ID="txtpassword" runat="server" Placeholder="Password" CssClass="form-control" ></asp:TextBox>
               <asp:Button ID="btnsave" runat="server" Text="Update Settings"  OnClick="btnsave_Click" CssClass="btn btn-lg btn-info" />
           </div>
        
        </div>


       </div>

</asp:Content>
