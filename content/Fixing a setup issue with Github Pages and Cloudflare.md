---
title: Fixing a setup issue with Github Pages and Cloudflare
date: 2023-06-26
description: 
tags:
  - cloudflare
  - computer-networking
math: false
---

By default when I imported my DNS records from Namecheap to Cloudflare the Encryption Mode is set to Flexible, which causes a redirect loop since the Github Pages site is set to enforce HTTPS.

When using Github pages for hosting and Cloudflare for DNS routing, we need to use Full SSL in Cloudflare instead of flex SSL so that we don't get caught in a redirect loop.

![2023-06-26 TIL Use full-ssl to avoid redirects-1687754997573](attachments/2023-06-26%20TIL%20Use%20full-ssl%20to%20avoid%20redirects-1687754997573.jpeg)
> Source https://developers.cloudflare.com/ssl/troubleshooting/too-many-redirects/

This happens if the Enforce HTTPS button is checked on our Github Pages site (Repo > Settings > Pages > Custom Domain)
![2023-06-26 TIL Use full-ssl to avoid redirects-1687755032493](attachments/2023-06-26%20TIL%20Use%20full-ssl%20to%20avoid%20redirects-1687755032493.jpeg)

## Solution 

_Cloudflare > Website > SSL/TLS (padlock icon)_
![ 200](2023-06-26%20TIL%20Use%20full-ssl%20to%20avoid%20redirects-1687755341415.jpeg%20)

_Set SSL/TSL to "Full"_
![2023-06-26 TIL Use full-ssl to avoid redirects-1687755383956](attachments/2023-06-26%20TIL%20Use%20full-ssl%20to%20avoid%20redirects-1687755383956.jpeg)