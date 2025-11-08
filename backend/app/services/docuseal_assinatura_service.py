import os
from docuseal import docuseal

API_KEY = os.getenv("API_KEY")

def iniciar_docuseal(): 
    docuseal.key = API_KEY
    docuseal.base_url = "http://localhost:3000/settings/api"

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

    iniciar_docuseal()

    submission = docuseal.create_submission({
        "template_id": 1,
        "order": "preserved",
        "submitters": [
            {
                "email": email_gerente,
                "role": "BrasilSupply - Gerente",
                "send_email": False,
                "completed": True,
                "fields": [
                    {
                        "name": "nome_fornecedor",
                        "default_value": razao_social,
                        "readonly": True
                    },
                    {
                        "name": "cnpj",
                        "default_value": cnpj,
                        "readonly": True
                    },
                    {
                        "name": "prazo_entrega",
                        "default_value": prazo_entrega,
                        "readonly": True
                    },
                    {
                        "name": "total",
                        "default_value": total,
                        "readonly": True
                    },
                    {
                        "name": "data_assin",
                        "default_value": data_assin,
                        "readonly": True
                    },
                    {
                        "name": "n_proposta",
                        "default_value": n_proposta,
                        "readonly": True
                    },
                    {
                        "name": "n_requisicao",
                        "default_value": n_requisicao,
                        "readonly": True
                    }
                ]
            },
            {
                "email": email_fornecedor,
                "role": "Fornecedor - " + razao_social,
                "send_email": True,
                "fields": [
                    {
                        "name": "nome_fornecedor",
                        "default_value": razao_social,
                        "readonly": True
                    },
                    {
                        "name": "cnpj",
                        "default_value": cnpj,
                        "readonly": True
                    },
                    {
                        "name": "prazo_entrega",
                        "default_value": prazo_entrega,
                        "readonly": True
                    },
                    {
                        "name": "total",
                        "default_value": total,
                        "readonly": True
                    },
                    {
                        "name": "data_assin",
                        "default_value": data_assin,
                        "readonly": True
                    },
                    {
                        "name": "n_proposta",
                        "default_value": n_proposta,
                        "readonly": True
                    },
                    {
                        "name": "n_requisicao",
                        "default_value": n_requisicao,
                        "readonly": True
                    }
                ]
            },
        ]
    }
    )

    return {"slug": submission['submitters'][0]['slug']}