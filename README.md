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
