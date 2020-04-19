const baseHostURL = 'http://covid-19-scanner.ukwest.cloudapp.azure.com';
export const environment = {
    production: true,
    apiUrl: 'http://localhost:3333',
    jupyterUrl: baseHostURL + ':8888/',
    nifiUrl: baseHostURL + ':9000/nifi',
    hadoopUrl: baseHostURL + ':9870',
    sparkUrl: baseHostURL + ':8080',
    hueUrl: baseHostURL + ':8000',
    tensorflowUrl: baseHostURL + ':6006/',
    elasticsearchUrl: baseHostURL + ':9200/',
    kibanaUrl: baseHostURL + ':5601/',
    jenkinsUrl: baseHostURL + ':7075/jenkins'
};
