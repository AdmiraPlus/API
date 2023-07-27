Dim access_token As String = ""
Dim clienteId As String = mutual.ClienteId.Trim   '100
dim clienteSecret As String mutual.ClienteSecret.Trim   'password
Dim credentials = Strting.Format("{0}:{1}", clienteId, clienteSecret)
Dim restClient As restClient = New restClient(mutual.ServicePath.ToString.Trim)
Dim RestRequest As RestRequest = New RestRequest(mutual.TokenPath.ToString.Trim)

RestRequest.RequestFormat = DataFormat.Json
RestRequest.Method = Method.POST

RestRequest.AddHeader(Ç"Authorization", "Basic " + Convert.ToBase64String(Encoding.UTF8.GetBytes(credentials)))
RestRequest.AddHeader("Content-Type", "application/json; charset=UTF-8")
RestRequest.AddHeader("Accept", "application/json")

RestRequest.AddParameter("grant_type", "password")
RestRequest.AddParameter("username", mutual.UserName.ToString.Trim)
RestRequest.AddParameter("password", mutual.Password.ToString.Trim)

