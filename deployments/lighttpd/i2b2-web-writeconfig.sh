#!/bin/bash
set -e

cat > "$LIGHTTPD_WEB_ROOT/i2b2-admin/i2b2_config_data.js" <<EOL
{
    urlProxy: "index.php",
    urlFramework: "js-i2b2/",

    lstDomains: [ {
        domain: "$I2B2_DOMAIN_NAME",
        name: "Domain $I2B2_DOMAIN_NAME",
        urlCellPM: "http://i2b2:8080/i2b2/services/PMService/",
        allowAnalysis: true,
        adminOnly: true,
        debug: false
    } ]
}
EOL

cat > "$LIGHTTPD_WEB_ROOT/i2b2-client/i2b2_config_data.js" <<EOL
{
    urlProxy: "index.php",
    urlFramework: "js-i2b2/",

    lstDomains: [  {
        domain: "$I2B2_DOMAIN_NAME",
        name: "Domain $I2B2_DOMAIN_NAME",
        urlCellPM: "http://i2b2:8080/i2b2/services/PMService/",
        allowAnalysis: true,
        debug: false
    } ]
}
EOL

cat > "$LIGHTTPD_WEB_ROOT/index.html" <<EOL
<html><head>
<title>Index</title>
</head><body>

<div align="center">
<p><a href="/i2b2-admin">I2b2 admin</a></p>
<p><a href="/i2b2-client">I2b2 client</a></p>
<p><a href="/phppgadmin">PhpPgAdmin</a></p>
<p><a href=":9990">WildFly Management</a></p>
<p><a href=":8080/i2b2">I2b2 Axis2 Management</a></p>
</div>

</body>
</html>
EOL

# webclients whitelist URLs
sed -i "s/\"http:\/\/localhost\"/\"http:\/\/i2b2:8080\"/" "$LIGHTTPD_WEB_ROOT/i2b2-admin/index.php"
sed -i "s/\"http:\/\/localhost\"/\"http:\/\/i2b2:8080\"/" "$LIGHTTPD_WEB_ROOT/i2b2-client/index.php"
