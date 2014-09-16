# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

User.create(:username => 'administrator',
						:password => 'benito',
						:password_confirmation => 'benito',
						:email	=> 'admin@ciudadanointeligente.org')

Glossary.create(:term => 'Accountability',
						:definition => 'pese a no tener una traducción literal en español, hace referencia, por un lado, al deber o responsabilidad que tienen los órganos de la administración pública o agentes públicos de rendir cuentas de sus acciones a los demás órganos del Estado y a los ciudadanos; y por otro, al derecho de estos últimos de fiscalizar e informarse de las acciones de quienes los gobiernan. Existe Accountability horizontal y vertical: el primero es el control que realizan entre sí los distintos poderes del Estado los cuales pueden examinar, cuestionar y en su caso sancionar actos irregulares cometidos durante el desempeño de los cargos públicos. El segundo, en tanto, se encuentra en el plano ciudadano, llevado a cabo a través de la vía electoral - que evalúa la gestión de las autoridades políticas mediante el voto - o por la vía social - por iniciativas ciudadanas, movimientos sociales y medios de comunicación - los cuales por medio de mecanismos institucionales (como demandas legales o reclamos ante agencias de control) y no institucionales (como movilizaciones sociales) buscan mejorar el funcionamiento de las instituciones representativas.')

Glossary.create(:term => 'Cámara(s)',
						:definition => 'se le llama a cada una de las ramas del Congreso Nacional, esto es, a la Cámara de Diputados y al Senado de la República. A su vez, cuando se habla de "Cámara Alta" se hace referencia explícitamente al Senado, mientras que el concepto "Cámara Baja" alude a la Cámara de Diputados.')

Glossary.create(:term => 'Bancada Parlamentaria',
						:definition => 'conjunto de diputados de un partido político, los que a través de un jefe, designado por ellos, facilitan la relación con la Mesa de la respectiva corporación, con el fin de hacer más expedita la tramitación de los asuntos sometidos a su conocimiento.')