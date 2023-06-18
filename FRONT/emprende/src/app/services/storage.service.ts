import { Injectable } from '@angular/core';
import { CartItemModel } from '../models/cart-item-model';

@Injectable({
  providedIn: 'root'
})
export class StorageService {

  constructor() { }

  existCart(): boolean {
    return localStorage.getItem('cart') != null;
  }

  setCart(cart: CartItemModel[]): void {
    localStorage.setItem('cart', JSON.stringify(cart));
  }

  getCart(): CartItemModel[] {
    return JSON.parse(localStorage.getItem('cart')!);
  }

  clear(): void {
    localStorage.removeItem('cart');
  }
}
