import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TextService {
  urlEncoded = '/Test.text';
  private readonly httpClient: HttpClient;

  constructor(private http: HttpClient) {
  }

  getText(filename) {
    return this.httpClient.get(filename, {responseType: 'text'});
  }
}

// Read  text file
// tslint:disable-next-line:no-empty-interface
export interface ResultJson {

}

