---Nigerian Event
 
--text blocks:
--Dear Beloved Friend, [NEWLINE]I know this message will come to you as surpised but permit me of my desire to go into business with you.
--I am daughter to late Al-badari Surugaba of Nigeria whom was murdered. Before his death my late father was a strong supporter of Government.
--Before his death, my Father came to republic with $4 200,000.00 which he deposited for safe keeping. I will offer you 20% of total sum if you help me transfer the sum so I can move to your country for to continue my education.
local TextScammers = 'An Unprecedented Opportunity!'
local TextScamDesc = {}
local TextScamDesc[0] = 'Dear Beloved Friend, [NEWLINE]I know this message will come to you as surpised but permit me of my desire to go into business with you. [NEWLINE]I am daughter to late Al-badari Surugaba of Nigeria whom was murdered. Before his death my late father was a strong supporter of Government.[NEWLINE]--Before his death, my Father came to republic with $4 200,000.00 which he deposited for safe keeping. I will offer you 20% of total sum if you help me transfer the sum so I can move to your country for to continue my education.'
local TextScamDesc[1] = 'Dear Sir or Madam,[NEWLINE][NEWLINE]I am Supreme Commander Wololo of the Nigerian Presidential Guard and am currently imprisoned. My assets have been frozen by agents of the Independent Republic of Yeb and I am in dire need of your assistance. If you send your bank details then I will be able to send you back two million Gold directly to your bank account. You are my last hope.'
local TextScamDesc[2] = 'I am Minister Doctor McCloundy Opuro, D.D., of the Nigerian Spiritual Foundation of Works. I am writing to you now to request your aid in a most grievous matter. Our vital and prestigious colony of living saints has been stricken with a vile and demonic corruption, and we are in dire need of salvation. If, however, the perfidious sickness known as Nun Flu claims our tender flock, then the good deeds of the Nigerian Spiritual Foundation of Works must live on. We will be able to transfer all our remaining funds into your bank account, and over many years we have acquired upwards of 41.9 Million Gold in donations. Please, in the name of Nebuchadnezzar, grant us your aid in this time of need.'
local TextScamDesc[3] = 'DEAR SIR OR MADAM I AM BUT A POOR AND HUMBLE COMPUTER SCIENCES TEACHER AT THE NIGERIAN INSTITUTE OF STUDIES PLEASE SEND ME MONEY SO THAT I CAN AFFORD TO PURCHASE KEYBOARDS WITH WORKING CAPSLOCK KEYS AND I PROMISE I WILL REPAY TENFOLD YOU IN TIME I AM NORMALLY MUCH QUIETER THAN THIS'
local TextScamDesc[4] = 'I am Minister Doctor McCloundy Opuro, D.D., of the Nigerian Spiritual Foundation of Works. I am writing to you now to request your aid in a most grievous matter. Our vital and prestigious colony of living saints has been stricken with a vile and demonic corruption, and we are in dire need of salvation. If, however, the perfidious sickness known as Nun Flu claims our tender flock, then the good deeds of the Nigerian Spiritual Foundation of Works must live on. We will be able to transfer all our remaining funds into your bank account, and over many years we have acquired upwards of 41.9 Million Gold in donations. Please, in the name of Nebuchadnezzar, grant us your aid in this time of need.'
local TextScamDesc[5] = 'I am Dr. Arindin from the Nigerian Institute of Studies and have come to you with a miracle genital enlargement technique! With just three drops of serum made from the "ejo eepo" plant, you too will be able to experience the wonders of substantial and awe-inspiring crotch-sausages like mine! Take a look at this before and after picture! We are writing to you today to share with you an amazing investment opportunity! And its not too hard to swallow too! The investment opportunity that is. [NEWLINE][NEWLINE]Invest in our company and you WILL reap the multiple benefits.'
 
local Event_CLNigerianScammers = {}
Event_CLNigerianScammers.Name = TextScammers
Event_CLNigerianScammers.Desc = TextScamDesc[Game.Rand(5, 'determining scam text')]
Event_CLNigerianScammers.Weight = 3
Event_CLNigerianScammers.CanFunc = (
function(pPlayer)
    if load(pPlayer, 'FirewallFilter') == true then
        return false
    end
    local cando = false
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLNIGERIA then
        return false
    else
        for oPlayer in Players() do
            if oPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLNIGERIA then
                cando = true
            end
        end
        if cando == false then
            return false
        end
    end
    if Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_COMPUTERS) then
        return true
    end
    return false
end
)
Event_CLNigerianScammers.Outcomes = {}
--Outcome one: say yes!
--Button name: Yes, I will help -- for a price.
--Button Description: gain 8400 Gold
Event_CLNigerianScammers.Outcomes[1] = {}
Event_CLNigerianScammers.Outcomes[1].Name = "Help - for a price"
Event_CLNigerianScammers.Outcomes[1].Description = "Gain 4000 [ICON_GOLD] Gold"
Event_CLNigerianScammers.Outcomes[1].CanFunc (
    function(pPlayer)
        return true
    end
)
Event_CLNigerianScammers.Outcomes[1].DoFunc = (
    function(pPlayer)
        if Game.Random(1300) < 2 then
            pPlayer:ChangeGold(8400)
        else
            pPlayer:ChangeGold(-100)
            for oPlayer in Players() do
                if oPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CLNIGERIA then
                    oPlayer:ChangeGold(50)
                end
            end
        end
        Event_CLNigerianScammers.Weight = 0
    end
)
--Outcome two: say no
--Button name: I'm no fool. Free money is a lie.
--Button Description: Do Nothing.
Event_CLNigerianScammers.Outcomes[2] = {}
Event_CLNigerianScammers.Outcomes[2].Name = "I'm no fool. Free money is a lie."
Event_CLNigerianScammers.Outcomes[2].Description = "Nothing Happens"
Event_CLNigerianScammers.Outcomes[2].CanFunc (
    function(pPlayer)
        return true
    end
)
Event_CLNigerianScammers.Outcomes[2].DoFunc = (
    function(pPlayer)
        Event_CLNigerianScammers.Weight = Event_CLNigerianScammers.Weight + 2
    end
)  
--Outcome Three: Block 'em
--Button name: We built a Great Firewall and we didn't put a filter on it?
--Button Description: Prevent emails like this one.
Event_CLNigerianScammers.Outcomes[3] = {}
Event_CLNigerianScammers.Outcomes[3].Name = 'We build a "Great Firewall" without a filter?'
Event_CLNigerianScammers.Outcomes[3].Description = "Prevent future Events like this one"
Event_CLNigerianScammers.Outcomes[3].CanFunc (
    function(pPlayer)
        if pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_GREAT_FIREWALL) > 0 then return true else return false end
    end
)
Event_CLNigerianScammers.Outcomes[3].DoFunc = (
    function(pPlayer)
        save(pPlayer, 'FirewallFilter', true)
    end
)
tEvents.Event_CLNigerianScammers = Event_CLNigerianScammers