<<<<<<< HEAD
* Deployment instructions

* ...

## API

### Consulta de cupom

#### GET /api/v1/coupons/:token

**HTTP status:** 200

```json

{
  "available": "Cupom válido",
  "discount_rate": "100.0",
  "monthly_duration": "6",
  "expire_date_formatted": "09/09/2024",
  "promotion": "Promoção de natal"
}

```

```json

{ 
  "available": "Cupom expirado",
  "discount_rate": "100.0",
  "monthly_duration": "6",
  "expire_date_formatted": "09/09/2024",
  "promotion": "Promoção de natal"
}

```

```json

{
  "available": "Cupom já utilizado",
  "discount_rate": "100.0",
  "monthly_duration": "6",
  "expire_date_formatted": "09/09/2024",
  "promotion": "Promoção de natal"
}

```

**HTTP status:** 404

```json
{
  "message": "Cupom não encontrado"
}

```
=======
## API

### Consulta de CPF (/api/v1/partner_companies/search?q=CPF)

#### GET /api/v1/partner_companies/search?q=816.125.298-01

**HTTP status:** 200

```json
{
"id": 1,
"name": "Empresa1",
"discount": "30.0",
"format_discount_duration": "12"
}
```
#### GET /api/v1/partner_companies/search?q=81612529801

CPF fora de formatação

**HTTP status:** 412

```json
[
"CPF inválido"
]
```

#### GET /api/v1/partner_companies/search?q=204.276.440-03

CPF válido mas não cadastrado

**HTTP status:** 404

```json
[
"Nenhum desconto para esse CPF"
]
```

#### GET /api/v1/partner_companies/search

Enviado sem conteúdo

**HTTP status:** 412

```json
[
"CPF inválido"
]
```

>>>>>>> eb4e7df25b5cae31e8a444ed402c375e720844d0
