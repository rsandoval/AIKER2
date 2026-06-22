<%@ Page Title="AIKER | Administración de Tests" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AdminTests.aspx.cs" Inherits="AIKER.Admin.AdminTests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="main" class="container">
        <header>
            <h2>Administración de pruebas</h2>
        </header>

        <asp:label runat="server" id="lblMessage" visible="false"></asp:label>

        <h4>Pruebas Activas o Recientes</h4>
        <asp:GridView ID="grdTests" runat="server" style="border-collapse:inherit;" border="0" AutoGenerateColumns="False" OnRowCommand="grdTests_RowCommand" CssClass="table" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" >
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:ButtonField ButtonType="Image" CommandName="Edit" HeaderText="Edit" ImageUrl="~/images/edit.png" ControlStyle-Width="20" Text="Edit" >
<ControlStyle Width="20px"></ControlStyle>
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Image" CommandName="Review" HeaderText="Review" ImageUrl="~/images/review.png" ControlStyle-Width="20" Text="Review" >
<ControlStyle Width="20px"></ControlStyle>
                </asp:ButtonField>
                <asp:BoundField DataField="ID" HeaderText="ID" />
                <asp:BoundField DataField="CourseName" HeaderText="Course" />
                <asp:BoundField DataField="Title" HeaderText="Test Title" />
                <asp:BoundField DataField="StartDate" HeaderText="Start" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="EndDate" HeaderText="End" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="NumberOfQuestions" HeaderText="# Q" />
                <asp:ImageField DataImageUrlField="TakeOnline" DataImageUrlFormatString="~\Images\{0}.png" ControlStyle-Width="20" HeaderText="Online" >
<ControlStyle Width="20px"></ControlStyle>
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="IsCurrent" DataImageUrlFormatString="~\Images\{0}.png" ControlStyle-Width="20" HeaderText="Active" >
<ControlStyle Width="20px"></ControlStyle>
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="Finished" DataImageUrlFormatString="~\Images\{0}.png" ControlStyle-Width="20" HeaderText="Finished" >
<ControlStyle Width="20px"></ControlStyle>
                </asp:ImageField>
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>

        <h4><asp:label runat="server" id="lblLevelDescription" visible="true"></asp:label></h4>
                
        <asp:GridView ID="grdInfoLevel" runat="server" AutoGenerateColumns="False" OnRowCommand="grdInfoLevel_RowCommand" CssClass="table" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:ButtonField ButtonType="Image" CommandName="Review" ImageUrl="~/images/review.png" ControlStyle-Width="20" Text="Review" >
<ControlStyle Width="20px"></ControlStyle>
                </asp:ButtonField>
                <asp:BoundField DataField="ID" HeaderText="ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Description" HeaderText="Details"  />
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
        <asp:Button ID="cmdCreateNewScheduledTest" cssClass="btn btn-info" runat="server" Text="Crear Nuevo Test" OnClick="cmdCreateNewScheduledTest_Click" />
    </section>
</asp:Content>
