# IAC-terraform-static-web-page
<h2>Mini project to deploy a static website on AWS S3 bucket using terraform</h2>
<h4>Expected outcome of the project</h4>
<p>Users should be able to access the static web page by visiting <i>static.countyemi.site</i> request will be processed as shown below:</p>

![flow](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/8ffd21c3-b858-40bd-855d-3425448f7826)

all resources here will be created using terraform.
<h4>Prerequisites:</h4>
<ul><li>Register a domain name with any registra of choice. I will use <i>countyemi.site</i></li>
<li>Create an SSL certificate for the domain. The terraform code for this is in the certificate.tf file</li>
<li>Validate certificate on domain registra website by adding a CNAME record and updating the name and value from AWS Certificate Manager as shown:</li>
  
![1](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/6efaf2a8-4338-4b48-9c64-38aab845ed31) ![cert](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/15323a89-5cb3-4860-8755-47fbcd9b6f83)
<li>If all records are entered correctly, certificate will be issued. I registered mine for all .countyemi.site </li> 

![cert issued](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/43b54367-63d1-4183-9375-a775f2c166b7) 

</ul>

<h4>Setting up Infrastructure</h4>
<h5>Bucket module</h5>
<p>Resources will be created using modules. starting with the S3 bucket. Using the bucket module in the modules directory. 
The main.tf file defines the resources and policies for the bucket to deny public read and allow read access from cloudfront. The index and error files are stored in the files directory. The bucket domain name and Origin Access Identity from the outputs.tf file will be used in the cloud_front module</p>

<h5>Cloud_front module</h5>
<p>The bucket domain name and Origin Access Identity from the bucket module will be used to configure the cloud front origin distribution, while the cloud front domain name will be used in the api gateway module </p>

<h5>api_gateway module</h5>
<p>Only the get method of type "HTTP_PROXY" will be created here. It will be integrated with the cloud front domain name. Passed as a variable 'cloudfront_url'. the get method will be deployed to 'prod' stage name </p>

<h5>route53 module</h5>
<p>For the purpose of this project, the custom domain name will be mapped to the url of the api gateway. The hosted zone <i>'static.countyemi.site'</i> will also be created here and configured to use the SSL certificate.</p>

<p>The outputs.tf file in the root directory will enable access to the api gateway url after running terraform apply</p>
<p>With <i>terraform apply</i></p>

![error creating](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/db25284d-8c9b-4440-8334-9d5e09d04438)

<p><i>terraform refresh</i> to refresh the state file</p>

![terraform refresh](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/4a6b1cf5-d0b3-4cd2-b36b-9bc19b39a05d)


<p>With the api gateway url from the output, the static website can be accessed</p>

![access website](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/42ff5d5e-5dcc-4063-8080-d7617b6d648b)

<p>Next step is update the name servers that were created when the hosted zone was created from the route53 module. These name servers will be added on the domain registra. This will enable traffic to be forwarded to the AWS name servers.</p>

![Name serevrer update](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/1539bcfc-30b2-4437-b183-ae2f928a8d0e)

<p>The name servers from the AWS console will be added to the name servers on namecheap. </p>
![name server update](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/8ca7ebc3-60f9-4a9c-ab32-1e2dd6ebfaf3)

<p>With all records updated. It might take up to 48 hours for changes to be propagated.</p>

<h4>Clean up</h4>
<p>with <i>terraform destroy</i></p>

![clean up](https://github.com/countyemi/IAC-terraform-static-web-page/assets/11930705/70ba6086-4803-4980-8564-4255901cef07)

<h1>END NOTE</h1>
<p>Ensure to use the correct certificate arn in variables.tf file in the root directory before running the code. Mine will not work for you</p>



