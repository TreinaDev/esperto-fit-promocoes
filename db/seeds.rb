include FactoryBot::Syntax::Methods

create(:user, email: 'user@espertofit.com.br', password: '12345678', admin: false)
create(:user, email: 'admin@espertofit.com.br', password: '12345678', admin: true)
partner_company = create(:partner_company)
create(:partner_company_employee, cpf: '816.125.298-01', partner_company: partner_company)
create(:partner_company_employee, cpf: '279.270.153-62', partner_company: partner_company)
promo_niver = create(:promotion, name: 'Promoção de aniversário',
                                 description: 'Ganhe 20% de desconto na matrícula no mês de aniversário Esperto Fit.',
                                 discount_rate: 20, coupon_quantity: 2, monthly_duration: 1,
                                 expire_date: Date.parse('09/11/2030'),
                                 token: 'PROMONIVER')
create(:coupon, token: 'PROMONIVER001', promotion: promo_niver)
create(:coupon, token: 'PROMONIVER002', promotion: promo_niver)
promo_verao = create(:promotion, name: 'Promoção de verão',
                                 description: 'Ganhe 10% de desconto em produtos das filiais.',
                                 discount_rate: 10, coupon_quantity: 2, monthly_duration: 2,
                                 expire_date: Date.parse('09/10/2030'),
                                 token: 'PROMOVERAO')
create(:coupon, token: 'PROMOVERAO001', promotion: promo_verao)
create(:coupon, token: 'PROMOVERAO002', promotion: promo_verao)
promo_black_friday = create(:promotion, name: 'Promoção black friday',
                                        description: 'Ganhe 50% de desconto na mensalidade.',
                                        discount_rate: 50, coupon_quantity: 2, monthly_duration: 3,
                                        expire_date: Date.parse('09/01/2030'),
                                        token: 'BFRIDAY')
create(:coupon, token: 'BFRIDAY001', promotion: promo_black_friday)
create(:coupon, token: 'BFRIDAY002', promotion: promo_black_friday)