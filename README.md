
نام پروژه : تانل GOT 
--
![check](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/13de8d36-dcfe-498b-9d99-440049c0cf14)
**امکانات**
- پورت فورواد TCP 
- امکان فوروارد چندین پورت همزمان
- امکان پورت فوروارد بین چندین سرور خارج و ایران بر روی چندین پورت
- دارای connection pool و goroutines برای performance بهتر
- داری tcp no delay ( با true فعال میشود و با false غیرفعال میشود)
- داری codereedsolomon برای udp برای کاهش پکت لاس
- امکان ترکیب با ipsec و لوکال ایپی تانل برای امنیت بیشتر
- امکان ترکیب با تانل های داخلی 64
- امکان ترکیب با icmp و dns
- مناسب برای گیم )
  
-----------------------
 ![6348248](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/398f8b07-65be-472e-9821-631f7b70f783)
**آموزش استفاده از اسکریپت**
 <div align="right">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/fcbbdc62-2de5-48aa-bbdd-e323e96a62b5" alt="Image"> </strong>نحوه استفاده از اسکریپت</summary>

------------------
<p align="right">
  <img src="https://github.com/user-attachments/assets/18956680-bcf1-4f02-add4-0acd30fe0abd" alt="Image" />
</p>

```

</details>
</div>

----------------
**- نصب پیش نیاز ها**
```
apt install python3 -y && sudo apt install python3-pip &&  pip install colorama && pip install netifaces && apt install curl -y
pip3 install colorama
sudo apt-get install python-pip -y  &&  apt-get install python3 -y && alias python=python3 && python -m pip install colorama && python -m pip install netifaces
sudo apt update -y && sudo apt install -y python3 python3-pip curl && pip3 install --upgrade pip && pip3 install netifaces colorama requests

```
- اجرای اسکریپت
```
apt install curl -y && bash -c "$(curl -fsSL https://raw.githubusercontent.com/Azumi67/DNS_tun/refs/heads/main/dns.sh)"
```

