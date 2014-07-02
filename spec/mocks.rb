def mock_bill()
  response = '{
              "uid": "6967-06",
              "short_uid": "6967",
              "title": "Declara feriado el día 7 de junio para la Región de Arica y Parinacota. ",
              "creation_date": "2010-06-02T00:00:00Z",
              "stage": "Tramitación terminada",
              "sub_stage": " / ",
              "authors": [
              "Ascencio Mansilla, Gabriel",
              "Auth Stewart, Pepe",
              "Baltolu Rasera, Nino",
              "Campos Jara, Cristián",
              "Jaramillo Becker, Enrique",
              "Lorenzini Basso, Pablo",
              "Núñez Lozano, Marco Antonio",
              "Pérez Arriagada, José",
              "Tuma Zedan, Joaquín",
              "Vargas Pizarro, Orlando"
              ],
              "publish_date": "2013-04-30T00:00:00Z",
              "tags": [
              "arica",
              "feriado",
              "feriados regionales"
              ],
              "paperworks": [
              {
                "created_at": "2014-04-10T20:03:07Z",
                "date": "2012-04-12T00:00:00+00:00",
                "updated_at": "2014-04-10T20:07:18Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346f670683ff8a1dd000001"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:12:26Z",
                "date": "2013-03-12T00:00:00+00:00",
                "updated_at": "2014-04-10T20:22:32Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fb0f683ff8a1dd000003"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:24:21Z",
                "date": "2013-03-13T00:00:00+00:00",
                "updated_at": "2014-04-10T20:24:45Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fddf683ff8a1dd000004"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:26:59Z",
                "date": "2013-03-14T00:00:00+00:00",
                "updated_at": "2014-04-10T20:26:59Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fe65683ff8a1dd000005"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:28:46Z",
                "date": "2013-03-15T00:00:00+00:00",
                "updated_at": "2014-04-10T20:28:46Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fee1683ff8a1dd000007"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:29:48Z",
                "date": "2013-01-13T00:00:00+00:00",
                "updated_at": "2014-04-10T20:30:48Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346ff11683ff8a1dd000008"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                }
              ],
              "priorities": [ ],
              "reports": [ ],
              "documents": [ ],
              "directives": [ ],
              "remarks": [ ],
              "revisions": [ ],
              "_links": {
                "self": {
                  "href": "http://billit.ciudadanointeligente.org/bills/6967-06"
                  },
                  "law_xml": {
                  "href": "http://www.leychile.cl/Consulta/obtxml?opt=7&idLey=20663"
                  },
                  "law_web": {
                  "href": "http://www.leychile.cl/Navegar?idLey=20663"
                  },
                  "bill_draft": {
                  "href": "http://www.senado.cl/appsenado/index.php?mo=tramitacion&ac=getDocto&iddocto=7370&tipodoc=mensaje_mocion"
                  }
                }
              }'
  stub_request(:get, ENV['billit_url'] + "6967-06.json")
    .to_return(:body => response)
end


def mock_put()
  response = '{
              "uid": "6967-06",
              "short_uid": "6967",
              "title": "Declara feriado el día 7 de junio para la Región de Arica y Parinacota. ",
              "creation_date": "2010-06-02T00:00:00Z",
              "stage": "Tramitación terminada",
              "sub_stage": " / ",
              "authors": [
              "Ascencio Mansilla, Gabriel",
              "Auth Stewart, Pepe",
              "Baltolu Rasera, Nino",
              "Campos Jara, Cristián",
              "Jaramillo Becker, Enrique",
              "Lorenzini Basso, Pablo",
              "Núñez Lozano, Marco Antonio",
              "Pérez Arriagada, José",
              "Tuma Zedan, Joaquín",
              "Vargas Pizarro, Orlando"
              ],
              "publish_date": "2013-04-30T00:00:00Z",
              "tags": [
              "ola",
              "chao"
              ],
              "paperworks": [
              {
                "created_at": "2014-04-10T20:03:07Z",
                "date": "2012-04-12T00:00:00+00:00",
                "updated_at": "2014-04-10T20:07:18Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346f670683ff8a1dd000001"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:12:26Z",
                "date": "2013-03-12T00:00:00+00:00",
                "updated_at": "2014-04-10T20:22:32Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fb0f683ff8a1dd000003"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:24:21Z",
                "date": "2013-03-13T00:00:00+00:00",
                "updated_at": "2014-04-10T20:24:45Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fddf683ff8a1dd000004"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:26:59Z",
                "date": "2013-03-14T00:00:00+00:00",
                "updated_at": "2014-04-10T20:26:59Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fe65683ff8a1dd000005"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:28:46Z",
                "date": "2013-03-15T00:00:00+00:00",
                "updated_at": "2014-04-10T20:28:46Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346fee1683ff8a1dd000007"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                },
                {
                "created_at": "2014-04-10T20:29:48Z",
                "date": "2013-01-13T00:00:00+00:00",
                "updated_at": "2014-04-10T20:30:48Z",
                "bill_uid": "6967-06",
                "timeline_status": "Estado por Defecto",
                "_links": {
                "self": {
                "href": "http://127.0.0.1.xip.io:3003/paperworks/5346ff11683ff8a1dd000008"
                },
                "bill": {
                "href": "http://127.0.0.1.xip.io:3003/bills/6967-06"
                }
                }
                }
              ],
              "priorities": [ ],
              "reports": [ ],
              "documents": [ ],
              "directives": [ ],
              "remarks": [ ],
              "revisions": [ ],
              "_links": {
                "self": {
                  "href": "http://billit.ciudadanointeligente.org/bills/6967-06"
                  },
                  "law_xml": {
                  "href": "http://www.leychile.cl/Consulta/obtxml?opt=7&idLey=20663"
                  },
                  "law_web": {
                  "href": "http://www.leychile.cl/Navegar?idLey=20663"
                  },
                  "bill_draft": {
                  "href": "http://www.senado.cl/appsenado/index.php?mo=tramitacion&ac=getDocto&iddocto=7370&tipodoc=mensaje_mocion"
                  }
                }
              }'
  stub_request(:put, ENV['billit_url'] + "6967-06")
    .to_return(:body => response)
end

def mock_morph_agendas_table()
  response = '[
          {
            "uid":"S361-91",
            "date":"2014-03-04",
            "chamber":"Senado",
            "legislature":"361",
            "session":"91",
            "bill_list":"[\"6967-06\"]",
            "date_scraped":"2014-02-28"
          }
        ]'
  query = 'select * from data limit 200'
  query = URI::escape(query)
  stub_request(:get, ENV['agendas_url'] + query)
    .to_return(:body => response)
end

def mock_morph_district_weeks()
  response = '[
          {
            "id":"C001",
            "title":"Semana distrital",
            "start":"2014-03-24",
            "end":"2014-03-28",
            "chamber":"C.Diputados",
            "url":"http://www.camara.cl/camara/distritos.aspx",
            "date_scraped":"2014-03-21"
          }
        ]'
  query = 'select * from data limit 200'
  query = URI::escape(query)
  stub_request(:get, ENV['district_weeks_url'] + query)
    .to_return(:body => response)
end