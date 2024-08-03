import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
@Injectable({
  providedIn: 'root',
})
export class ApiService {
  private baseUrl = 'http://localhost:3000';

  constructor(private http: HttpClient) {}
  getProducts(name: string = '', gender: string = ''): Observable<any[]> {
    let url = `${this.baseUrl}/products`;
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
  createOrder(order: any): Observable<any> {
    const authKey = this.getAuthKeyFromCookie();
    console.log(authKey);
    console.log('order', order);
    return this.http.post(`${this.baseUrl}/orders/${authKey}`, order);
  }

  getOrders(): Observable<any> {
    const authKey = this.getAuthKeyFromCookie();
    return this.http.get(`${this.baseUrl}/orders/by-auth/${authKey}`);
  }

  private getAuthKeyFromCookie(): string {
    const name = 'authToken=';
    const decodedCookie = decodeURIComponent(document.cookie);
    const ca = decodedCookie.split(';');

    for (let i = 0; i < ca.length; i++) {
      let c = ca[i];

      while (c.charAt(0) === ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) === 0) {
        return c.substring(name.length, c.length);
      }
    }
    return '';
  }

  getUsers(): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/admin/users`);
  }

  addProduct(product: any): Observable<any> {
    const headers = this.getAuthHeaders();
    return this.http.post(`${this.baseUrl}/admin/upload`, product, { headers });
  }

  updateProduct(productId: number, product: any): Observable<any> {
    const headers = this.getAuthHeaders();
    return this.http.put(`${this.baseUrl}/admin/update/${productId}`, product, {
      headers,
    });
  }

  deleteProduct(productId: number): Observable<any> {
    const headers = this.getAuthHeaders();
    return this.http.delete(`${this.baseUrl}/admin/delete/${productId}`, {
      headers,
    });
  }
  private getAuthHeaders(): HttpHeaders {
    const token = this.getAuthKeyFromCookie();
    return new HttpHeaders().set('Authorization', `Bearer ${token}`);
  }
}
