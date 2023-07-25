Dim access_token As String = ""
Dim clientId As String = mutual.ClientId.Trim  '100
Dim clientSecret As String = mutual.ClientSecret.Trim  'password
Dim credentials = String.Format("{0}:{1}", clientId, clientSecret)
Dim restClient As RestClient = New RestClient(mutual.ServicePath.ToString.Trim)
Dim ResRequest As ResRequest = New ResRequest(mutual.TokenPath.ToString.Trim)

RestRequest.RequestFormat = DataFormat.Json
RestRequest.Method = Method.POST

RestRequest.AddHeader("Autorization", "Basic " + Convert.ToBase64String(Encoding.UTF8.GetBytes(credentials)))

RestRequest.AddHeader("Content-Type", "application/json; charset=UTF-8")
RestRequest.AddHeader("Accept", "application/json")

RestRequest.AddParameter("grant_type", "password")
RestRequest.AddParameter("username", mutual.UserName.ToString.Trim)
RestRequest.AddParameter("password", mutual.PasswordClient.ToString.Trim)


