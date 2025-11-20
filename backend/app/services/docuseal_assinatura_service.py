import requests
import os

API_KEY = os.getenv("API_KEY")
DOCUSEAL_URL = "http://docuseal:3000/api"

def criar_template_assinatura(email_gerente: str,
                              email_fornecedor: str,
                              razao_social: str,
                              cnpj: str,
                              prazo_entrega: str,
                              total: str,
                              data_assin: str,
                              n_proposta: str,
                              n_requisicao: str,
                              ) -> dict:

    headers = {
        "X-Auth-Token": API_KEY,
        "Content-Type": "application/json"
    }

    payload = {
        "template_id": 1,
        "order": "preserved",
        "fields": [
            {"name": "nome_fornecedor", "default_value": razao_social, "readonly": True},
            {"name": "cnpj", "default_value": cnpj, "readonly": True},
            {"name": "prazo_entrega", "default_value": prazo_entrega, "readonly": True},
            {"name": "total", "default_value": total, "readonly": True},
            {"name": "data_assin", "default_value": data_assin, "readonly": True},
            {"name": "n_proposta", "default_value": n_proposta, "readonly": True},
            {"name": "n_requisicao", "default_value": n_requisicao, "readonly": True}
        ],
        "submitters": [
            {
                "email": email_gerente,
                "role": "BrasilSupply - Gerente",
                "send_email": False,
                "completed": True,
            },
            {
                "email": email_fornecedor,
                "role": "Fornecedor",
                "send_email": True,
            }
        ]
    }

    response = requests.post(
        f"{DOCUSEAL_URL}/submissions",
        headers=headers,
        json=payload
    )

    if response.status_code != 200:
        raise Exception(f"DocuSeal API Error: {response.status_code} - {response.text}")

    submission = response.json()

    return {
        "slug": submission['submitters'][0]['slug'],
        "submission_id": submission['id']
    }