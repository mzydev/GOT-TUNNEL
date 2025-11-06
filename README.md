
نام پروژه : تانل GOT 
--
![check](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/13de8d36-dcfe-498b-9d99-440049c0cf14)
**امکانات**
- پورت فورواد TCP 
- امکان فوروارد چندین پورت همزمان
- دارای connection pool و goroutines برای performance بهتر
- داری tcp no delay ( با true فعال میشود و با false غیرفعال میشود)
- داری codereedsolomon برای udp برای کاهش پکت لاس
- امکان ترکیب با ipsec و لوکال ایپی تانل برای امنیت بیشتر
- امکان ترکیب با تانل های داخلی 64
- امکان ترکیب با icmp و dns
- مناسب برای گیم )
  



----------------
- اجرای اسکریپت
```
apt install curl -y && bash -c "$(curl -fsSL https://raw.githubusercontent.com/Azumi67/DNS_tun/refs/heads/main/dns.sh)"
```
