import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
@Injectable({
  providedIn: 'root',
})
export class ApiService {
  private baseUrl = 'http://localhost:3000/products';

  constructor(private http: HttpClient) {}
  getProducts(name: string = '', gender: string = ''): Observable<any[]> {
    let url = `${this.baseUrl}`;
    const params: string[] = [];

    if (name) {
      params.push(`name=${name}`);
    }
    if (gender) {
      params.push(`gender=${gender}`);
    }

    if (params.length > 0) {
      url += '?' + params.join('&');
    }

    return this.http.get<any[]>(url);
  }
}
