--==========================================================================================================================
-- TEXT
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Language_en_US
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Language_en_US
		(Tag,								Text)
SELECT	'TXT_KEY_PEDIA_CATEGORY_17_LABEL',  'Governments'
WHERE NOT EXISTS (SELECT Tag FROM Language_en_US WHERE Tag = 'TXT_KEY_PEDIA_CATEGORY_17_LABEL');

UPDATE Language_en_US
SET Text = 'Governments'
WHERE Tag = 'TXT_KEY_PEDIA_CATEGORY_17_LABEL';

--LEADERS
UPDATE Language_en_US
SET Text = 'Augustus'
WHERE Tag = 'TXT_KEY_LEADER_AUGUSTUS';

UPDATE Language_en_US
SET Text = 'Genghis'
WHERE Tag = 'TXT_KEY_LEADER_GENGHIS_KHAN';

--BELIEFS
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Ceremonial Burial', 'Burial Rites')
WHERE Tag LIKE '%TXT_KEY_BELIEF_CEREMONIAL_BURIAL%';

--POLICIES
UPDATE Language_en_US
SET Text = REPLACE(Text, 'empires', 'civilizations')
WHERE Tag LIKE '%TXT_KEY_POLICY%';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'empire', 'civilization')
WHERE Tag LIKE '%TXT_KEY_POLICY%';

--POLICIES: TRADITION
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Aristocracy', 'Ceremonial Burial')
WHERE Tag LIKE '%TXT_KEY_POLICY_ARISTOCRACY%';

UPDATE Language_en_US
SET Text = 'Burial is a method of final disposition wherein a dead person or animal is placed into the ground, sometimes with objects. This is usually accomplished by excavating a pit or trench, placing the deceased and objects in it, and covering it over. A funeral is a ceremony that accompanies the final disposition. Humans have been burying their dead since shortly after the origin of the species. Burial is often seen as indicating respect for the dead. It has been used to prevent the odor of decay, to give family members closure and prevent them from witnessing the decomposition of their loved ones, and in many cultures it has been seen as a necessary step for the deceased to enter the afterlife or to give back to the cycle of life.'
WHERE Tag = 'TXT_KEY_POLICY_ARISTOCRACY_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Oligarchy', 'Ruling Class')
WHERE Tag LIKE '%TXT_KEY_POLICY_OLIGARCHY%';

UPDATE Language_en_US
SET Text = 'The ruling class is the social class of a given society that decides upon and sets that society''s political agenda. Analogous to the class of the major capitalists, other modes of production give rise to different ruling classes: under feudalism it was the feudal lords while under slavery it was the slave-owners. Under the feudal society, feudal lords had power over the vassals because of their control of the fiefs. This gave them political and military power over the people.'
WHERE Tag = 'TXT_KEY_POLICY_OLIGARCHY_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Monarchy', 'Hereditary Rule')
WHERE Tag LIKE '%TXT_KEY_POLICY_MONARCHY%';

UPDATE Language_en_US
SET Text = 'Hereditary Rule is a form of power wherein the rulership is passed down from one member of the family to the next. This kind of succession is most often associated with monarchical rulers, but it occasionally appears in despotisms or even purportedly communist regimes - North Korea, for example. There is often a religious justification for hereditary rule; kings are said to rule by "divine right" or "the mandate of Heaven."'
WHERE Tag = 'TXT_KEY_POLICY_MONARCHY_TEXT';

--POLICIES: LIBERTY
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Collective Rule', 'Metropolis')
WHERE Tag LIKE '%TXT_KEY_POLICY_COLLECTIVE_RULE%';

UPDATE Language_en_US
SET Text = 'A metropolis is a large city or conurbation which is a significant economic, political, and cultural center for a country or region, and an important hub for regional or international connections, commerce, and communications. The term is Ancient Greek and means the "mother city" of a colony (in the ancient sense), that is, the city which sent out settlers. This was later generalized to a city regarded as a center of a specified activity, or any large, important city in a nation. '
WHERE Tag = 'TXT_KEY_POLICY_COLLECTIVERULE_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Citizenship', 'Citizenhood')
WHERE Tag LIKE '%TXT_KEY_POLICY_CITIZENSHIP%';

UPDATE Language_en_US
SET Text = 'In the history of Rome, the Latin term civitas, according to Cicero in the time of the late Roman Republic, was the social body of the cives, or citizens, united by law (concilium coetusque hominum jure sociati). It is the law that binds them together, giving them responsibilities (munera) on the one hand and rights of citizenship on the other. The agreement (concilium) has a life of its own, creating a res publica or "public entity" (synonymous with civitas), into which individuals are born or accepted, and from which they die or are ejected. The civitas is not just the collective body of all the citizens, it is the contract binding them all together, because each of them is a civis.'
WHERE Tag = 'TXT_KEY_CIV5_POLICY_CITIZENSHIP_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Republic', 'Statesmanship')
WHERE Tag LIKE '%TXT_KEY_POLICY_REPUBLIC%';

UPDATE Language_en_US
SET Text = 'A statesman or stateswoman is usually a politician, diplomat or other notable public figure who has had a long and respected career at the national or international level. In ancient Rome, the art of speaking in public (Ars Oratoria) was a professional competence especially cultivated by politicians and lawyers. As the Greeks were still seen as the masters in this field, as in philosophy and most sciences, the leading Roman families often either sent their sons to study these things under a famous master in Greece (as was the case with the young Julius Caesar), or engaged a Greek teacher (underpay or as a slave).'
WHERE Tag = 'TXT_KEY_CIV5_POLICY_REPUBLIC_TEXT';

--POLICIES: HONOR
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Professional Army', 'Military State')
WHERE Tag LIKE '%TXT_KEY_POLICY_PROFESSIONAL_ARMY%';

UPDATE Language_en_US
SET Text = 'A Military State might describe a state in which all state activities are geared toward war. Under Frederick II in Prussia, the army had become an integral part of Prussian society and numbered 200,000 soldiers, making it the third largest in Europe after the armies of Russia and Austria. The social classes were all expected to serve the state and its army — the nobility led the army, the middle class supplied the army, and the peasants composed the army. Minister Friedrich von Schrötter remarked that, "Prussia was not a country with an army, but an army with a country".'
WHERE Tag = 'TXT_KEY_POLICY_PROFESSIONALARMY_TEXT';

--POLICIES: PIETY
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Mandate of Heaven', 'Infallability')
WHERE Tag LIKE '%TXT_KEY_POLICY_MANDATE_OF_HEAVEN%';

UPDATE Language_en_US
SET Text = 'Infallbility is the philosophical doctrine concerned with reality and truth. In Christian theology, it is the inability to err when speaking on revelation. In the Catholic Church, the doctrine of Papal Infallability asserts that, when exercising the office of St. Peter, as by the promise of St. Peter, the Pope cannot speak in error.'
WHERE Tag = 'TXT_KEY_CIV5_POLICY_MANDATEOFHEAVEN_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Organized Religion', 'Religious Heirarchy')
WHERE Tag LIKE '%TXT_KEY_POLICY_ORGANIZED_RELIGION%';

UPDATE Language_en_US
SET Text = 'A hierarchical organization is an organizational structure where every entity in the organization, except one, is subordinate to a single other entity. This arrangement is a form of a hierarchy. In an organization, the hierarchy usually consists of a singular/group of power at the top with subsequent levels of power beneath them. This is the dominant mode of organization among large organizations; most corporations, governments, criminal enterprises, and organized religions are hierarchical organizations with different levels of management, power or authority. For example, the broad, top-level overview of the general organization of the Catholic Church consists of the Pope, then the Cardinals, then the Archbishops, and so on. '
WHERE Tag = 'TXT_KEY_CIV5_POLICY_ORGANIZEDRELIGION_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Theocracy', 'Autocephaly')
WHERE Tag LIKE '%TXT_KEY_POLICY_THEOCRACY%';

UPDATE Language_en_US
SET Text = 'Autocephaly (meaning "property of being self-headed") is the status of a hierarchical Christian Church whose head bishop does not report to any higher-ranking bishop. The term is primarily used in Eastern Orthodox and Oriental Orthodox churches. The status has been compared with that of the churches (provinces) within the Anglican Communion. The right to grant autocephaly is nowadays a contested issue, the main opponents in the dispute being the Ecumenical Patriarchate, which claims this right as its prerogative, and the Russian Orthodox Church (the Moscow Patriarchate), which insists that an already established autocephaly has the right to grant independence to a part thereof. Thus, the Orthodox Church in America was granted autocephaly by the Moscow Patriarchate in 1970, but this new status was not recognized by most patriarchates. In the modern era the issue of autocephaly has been closely linked to the issue of self-determination and political independence of a nation, or a country; self-proclamation of autocephaly was normally followed by a long period of non-recognition and schism with the mother church. '
WHERE Tag = 'TXT_KEY_CIV5_POLICY_THEOCRACY_TEXT';

--POLICIES: PATRONAGE
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Scholasticism', 'Intellectual Centers')
WHERE Tag LIKE '%TXT_KEY_POLICY_SCHOLASTICISM%';

UPDATE Language_en_US
SET Text = 'An intellectual is a person who engages in critical thinking and reading, research, and human self-reflection about society; they may propose solutions for its problems and gain authority as a public figure.[2][3] Coming from the world of culture, either as a creator or as a mediator, the intellectual participates in politics either to defend a concrete proposition or to denounce an injustice, usually by rejecting, producing or extending an ideology, or by defending a system of values. The House of Wisdom, also known as the Grand Library of Baghdad, was one of the most famous intellectual centers. The House of Wisdom was founded either as a library for the collections of the Caliph Harun al-Rashid in the late 8th century (then later turned into a public academy during the reign of Al-Ma''mun) or was a private collection created by Al-Mansur (reign 754–775) to house rare books and collections of poetry in both Arabic and Persian.'
WHERE Tag = 'TXT_KEY_CIV5_POLICY_SCHOLASTICISM_TEXT';

--POLICIES: COMMERCE
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Mercantilism', 'Trade Balance')
WHERE Tag LIKE '%TXT_KEY_POLICY_MERCANTILISM%';

UPDATE Language_en_US
SET Text = 'The balance of trade, commercial balance, or net exports (sometimes symbolized as NX), is the difference between the monetary value of a nation''s exports and imports over a certain time period. Sometimes a distinction is made between a balance of trade for goods versus one for services. The balance of trade measures a flow of exports and imports over a given period of time. The notion of the balance of trade does not mean that exports and imports are "in balance" with each other.'
WHERE Tag = 'TXT_KEY_CIV5_POLICY_MERCANTILISM_TEXT';

--POLICIES: RATIONALISM
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Humanism', 'Critical Inquiry')
WHERE Tag LIKE '%TXT_KEY_POLICY_HUMANISM%';

UPDATE Language_en_US
SET Text = 'Critique is a method of disciplined, systematic study of a written or oral discourse. Although critique is commonly understood as fault finding and negative judgment, it can also involve merit recognition, and in the philosophical tradition it also means a methodical practice of doubt. The contemporary sense of critique has been largely influenced by the Enlightenment critique of prejudice and authority, which championed the emancipation and autonomy from religious and political authorities.'
WHERE Tag = 'TXT_KEY_CIV5_POLICY_HUMANISM_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Secularism', 'Methodology')
WHERE Tag LIKE '%TXT_KEY_POLICY_SECULARISM%';

UPDATE Language_en_US
SET Text = 'Methodology is the systematic, theoretical analysis of the methods applied to a field of study. It comprises the theoretical analysis of the body of methods and principles associated with a branch of knowledge. Typically, it encompasses concepts such as paradigm, theoretical model, phases and quantitative or qualitative techniques. A methodology does not set out to provide solutions—it is therefore, not the same as a method. Instead, a methodology offers the theoretical underpinning for understanding which method, set of methods, or best practices can be applied to a specific case, for example, to calculate a specific result. '
WHERE Tag = 'TXT_KEY_CIV5_POLICY_SECULARISM_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Sovereignty', 'Rational Bureaucracy')
WHERE Tag LIKE '%TXT_KEY_POLICY_SOVEREIGNTY%';

UPDATE Language_en_US
SET Text = 'Rational-legal authority (also known as rational authority, legal authority, rational domination, legal domination, or bureaucratic authority) is a form of leadership in which the authority of an organization or a ruling regime is largely tied to legal rationality, legal legitimacy and bureaucracy. The majority of the modern states of the twentieth and twenty-first centuries are rational-legal authorities, according to those who use this form of classification.'
WHERE Tag = 'TXT_KEY_POLICY_SOVEREIGNTY_TEXT';

--POLICIES: IDEOLOGIES
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Universal Healthcare', 'Social Insurance')
WHERE Tag LIKE '%TXT_KEY_POLICY_UNIVERSAL_HEALTHCARE%';

UPDATE Language_en_US
SET Text = 'Social insurance is any government-sponsored program. Social insurance differs from public support in that individuals’ claims are partly dependent on their contributions, which can be considered as insurance premium. If what individuals receive is proportional to their contributions, social insurance can be considered a government "production activity" rather than redistribution. Given that what some receive is far higher than what they attribute (on an actuarial basis), there is a large element of redistribution involved in government social insurance programs.'
WHERE Tag = 'TXT_KEY_POLICY_UNIVERSAL_HEALTHCARE_TEXT';

--POLICIES: FREEDOM
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Universal Suffrage', 'Civic Education')
WHERE Tag LIKE '%TXT_KEY_POLICY_UNIVERSAL_SUFFRAGE%';

UPDATE Language_en_US
SET Text = 'Civics derives from the Latin word civicus, meaning relating to a citizen. The English usage of civics relates to behavior affecting other citizens, particularly in the context of urban development. Civic education is the study of the theoretical, political and practical aspects of citizenship, as well as its rights and duties. It includes the study of civil law and civil code, and the study of government with attention to the role of citizens as opposed to external factors in the operation and oversight of government.'
WHERE Tag = 'TXT_KEY_POLICY_UNIVERSALSUFFRAGE_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Volunteer Army', 'Volunteer Force')
WHERE Tag LIKE '%TXT_KEY_POLICY_VOLUNTEER_ARMY%';

UPDATE Language_en_US
SET Text = 'A Volunteer Army is one that draws its manpower from volunteers rather than conscription or mandatory service; generally found in democracies, the voluntary military offers attractive pay, incentives and benefits to recruit and retain its servicemen. Most countries with volunteer armies also have conscription laws in place for use in the event of a national emergency.'
WHERE Tag = 'TXT_KEY_POLICY_VOLUNTEER_ARMY_TEXT';

--POLICIES: AUTOCRACY
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Nationalism', 'Ethnic Nation')
WHERE Tag LIKE '%TXT_KEY_POLICY_NATIONALISM%';

UPDATE Language_en_US
SET Text = 'Ethnic nationalism, also known as ethnonationalism, is a form of nationalism wherein the nation is defined in terms of ethnicity. The central theme of ethnic nationalists is that "nations are defined by a shared heritage, which usually includes a common language, a common faith, and a common ethnic ancestry". It also includes ideas of a culture shared between members of the group, and with their ancestors.'
WHERE Tag = 'TXT_KEY_POLICY_NATIONALISM_TEXT';

UPDATE Language_en_US
SET Text = REPLACE(Text, 'Police State', 'Totalitarianism')
WHERE Tag LIKE '%TXT_KEY_POLICY_POLICE_STATE%';

UPDATE Language_en_US
SET Text = 'Totalitarianism is a political system or a form of government that prohibits opposition parties, restricts individual opposition to the state and its claims, and exercises an extremely high degree of control over public and private life. It is regarded as the most extreme and complete form of authoritarianism. Political power in totalitarian states has often been held by autocrats which employ all-encompassing propaganda campaigns broadcast by state-controlled mass media.'
WHERE Tag = 'TXT_KEY_POLICY_POLICESTATE_TEXT';

--WONDERS
UPDATE Language_en_US
SET Text = REPLACE(Text, 'Requires Liberty. ', '')
WHERE Tag LIKE '%TXT_KEY_WONDER_CHICHEN%';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]+10% [ICON_JFD_SOVEREIGNTY] Sovereignty.'
WHERE Tag = 'TXT_KEY_BUILDING_PALACE_HELP';
--==========================================================================================================================
--==========================================================================================================================