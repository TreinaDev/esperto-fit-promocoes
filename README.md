* Deployment instructions

* ...

## API

### Consulta de cupom

#### GET /api/v1/coupons/:token

**HTTP status:** 200

```json
[
  {
    "id": 1,
    "available": "Cupom válido",
    "discount_rate": "100.0",
    "monthly_duration": "6",
    "expire_date": "09/09/2024",
    "promotion": "Promoção de natal"
  }
]
```

```json
[
  {
    "available": "Cupom expirado"
  }
]
```

```json
[
  {
    "available": "Cupom já utilizado"
  }
]
```

**HTTP status:** 404

```json
{
  "message": "Cupom não encontrado"
}

```
