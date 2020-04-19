// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

const baseHostURL = 'http://covid-19-scanner-dev.eastus.cloudapp.azure.com';
export const environment = {
    production: false,
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

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
