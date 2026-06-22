<%@ Page Title="" Language="C#" MasterPageFile="Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AIKER.Admin.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <section>
        <div class="container d-flex flex-column">
            <div class="row align-items-center justify-content-center min-vh-100">
                <div class="col-md-6 col-lg-5 col-xl-5 py-6 py-md-0">
                    <div class="card shadow zindex-100 mb-0">
                        <div class="card-body px-md-5 py-5">
                            <div class="mb-5">
                                <h6 class="h3">Acceso Administración</h6>
                                <asp:label runat="server" id="lblMessage" visible="false"></asp:label>
                            </div>
                            <span class="clearfix"></span>
                            <form runat="server" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label class="form-control-label">E-mail</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="user"></i></span>
                                        </div>
                                        <asp:TextBox ID="txtEmail" name="email" placeholder="Email" type="email" runat="server" class="form-control form-control-emphasized"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group mb-0">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <label class="form-control-label">Contraseña</label>
                                        </div>
                                        <div class="mb-2">
                                            <asp:HyperLink ID="lnkRecoverPassword" runat="server" class="small text-muted text-underline--dashed border-primary" NavigateUrl="RecoverPassword.aspx">Recuperar contraseña</asp:HyperLink>
                                        </div>
                                    </div>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="key"></i></span>
                                        </div>
                                        <asp:TextBox ID="txtPassword" name="password" placeholder="Contraseña" type="password" runat="server" class="form-control form-control-emphasized"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <asp:Button ID="cmdLogin" runat="server" Text="Iniciar Sesión" class="btn btn-block btn-primary" OnClick="cmdLogin_Click" />
                                </div>
                            </form>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
