//
//  MarketCodes.swift
//  DomainManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation

public enum MarketCodes: String, CaseIterable {
    case KRW = "KRW"
    case sei = "Sei",
         hedera = "Hedera",
         steem = "Steem",
         wax = "WAX",
         milK = "MiL.k",
         ardor = "Ardor",
         siacoin = "Siacoin",
         mina = "Mina",
         strike = "Strike",
         iqWiki = "IQ.wiki",
         maskNetwork = "Mask Network",
         tezos = "Tezos",
         ripple = "Ripple",
         eos = "EOS",
         flow = "Flow",
         dogecoin = "Dogecoin",
         iota = "IOTA",
         neo = "NEO",
         gas = "GAS",
         polygon = "Polygon",
         astar = "Astar",
         lumen = "Lumen",
         firmaChain = "FirmaChain",
         storj = "Storj",
         ankr = "Ankr",
         civic = "Civic",
         mossCoin = "Moss Coin",
         loomNetwork = "Loom Network",
         decentraland = "Decentraland",
         polkadot = "Polkadot",
         bora = "BORA",
         arbitrum = "Arbitrum",
         polymesh = "Polymesh",
         zilliqa = "Zilliqa",
         cobakToken = "Cobak Token",
         immutableX = "Immutable X",
         quarkChain = "QuarkChain",
         movieBloc = "MovieBloc",
         ark = "Ark",
         tron = "TRON",
         aave = "Aave",
         cosmos = "Cosmos",
         mediBloc = "MediBloc",
         sui = "Sui",
         ontology = "Ontology",
         qtum = "Qtum",
         thetaToken = "Theta Token",
         celo = "Celo",
         standardTokenizationProtocol = "Standard Tokenization Protocol",
         metal = "Metal",
         pundiX = "Pundi X",
         ahaToken = "AhaToken",
         sxp = "SXP",
         dKargo = "dKargo",
         icon = "Icon",
         chainlink = "Chainlink",
         aelf = "aelf",
         thunderCore = "ThunderCore",
         theSandbox = "The Sandbox",
         nearProtocol = "NEAR Protocol",
         kyberNetwork = "Kyber Network",
         waves = "Waves",
         mvl = "MVL",
         ethereum = "Ethereum",
         iost = "IOST",
         inchNetwork = "1inch Network",
         hive = "Hive",
         veChain = "VeChain",
         powerLedger = "Power ledger",
         hippocrat = "Hippocrat",
         ada = "Ada",
         sentinelProtocol = "Sentinel Protocol",
         akashNetwork = "Akash Network",
         metadium = "Metadium",
         ethereumClassic = "Ethereum Classic",
         pythNetwork = "Pyth Network",
         steemDollars = "SteemDollars",
         chiliz = "Chiliz",
         thetaFuel = "Theta Fuel",
         aptos = "Aptos",
         spaceId = "SPACE ID",
         tokamakNetwork = "Tokamak Network",
         bitcoin = "Bitcoin",
         zetaChain = "ZetaChain",
         hunt = "HUNT",
         multiversX = "MultiversX",
         kava = "Kava",
         stratis = "Stratis",
         bitcoinSV = "Bitcoin SV",
         creditcoin = "Creditcoin",
         solana = "Solana",
         bitcoinGold = "Bitcoin Gold",
         zProtocol = "0x Protocol",
         threshold = "Threshold",
         statusNetworkToken = "Status Network Token",
         nem = "NEM",
         golem = "Golem",
         avalanche = "Avalanche",
         bitcoinCash = "Bitcoin Cash",
         orbs = "Orbs",
         lisk = "Lisk",
         blur = "Blur",
         bitTorrent = "BitTorrent",
         stormX = "StormX",
         ecash = "eCash",
         mantle = "Mantle",
         aergo = "Aergo",
         axieInfinity = "Axie Infinity",
         carryProtocol = "Carry Protocol",
         alphaQuarkToken = "Alpha Quark Token",
         basicAttentionToken = "Basic Attention Token",
         cronos = "Cronos",
         algorand = "Algorand",
         stepn = "Stepn",
         ong = "ONG",
         groestlcoin = "Groestlcoin",
         just = "JUST",
         stacks = "Stacks",
         theGraph = "The Graph",
         hifiFinance = "Hifi Finance",
         shibaInu = "Shiba Inu"
    
    public var code: String {
        return "KRW-" + self.rawValue
    }
    public var englishName: String {
        return self.rawValue
    }
    public var koreanName: String {
        return match(self.englishName)
    }

    public func match(_ englishName: String) -> String {
        let coins = ["IOTA": "아이오타", "BitTorrent": "비트토렌트", "Pundi X": "펀디엑스", "WAX": "왁스", "Metal": "메탈", "Storj": "스토리지", "Cobak Token": "코박토큰", "AhaToken": "아하토큰", "1inch Network": "1인치네트워크", "Dogecoin": "도지코인", "Ethereum Classic": "이더리움클래식", "Akash Network": "아카시네트워크", "ONG": "온톨로지가스", "NEM": "넴", "aelf": "엘프", "Polymesh": "폴리매쉬", "Metadium": "메타디움", "Basic Attention Token": "베이직어텐션토큰", "Tezos": "테조스", "Steem": "스팀", "Stacks": "스택스", "dKargo": "디카르고", "Threshold": "쓰레스홀드", "eCash": "이캐시", "Creditcoin": "크레딧코인", "BORA": "보라", "GAS": "가스", "Kava": "카바", "Polkadot": "폴카닷", "MiL.k": "밀크", "Hippocrat": "히포크랏", "The Sandbox": "샌드박스", "Celo": "셀로", "JUST": "저스트", "Ripple": "리플", "Civic": "시빅", "Bitcoin": "비트코인", "MediBloc": "메디블록", "VeChain": "비체인", "StormX": "스톰엑스", "Golem": "골렘", "TRON": "트론", "Avalanche": "아발란체", "Kyber Network": "카이버네트워크", "Stratis": "스트라티스", "ThunderCore": "썬더코어", "Theta Token": "쎄타토큰", "Zilliqa": "질리카", "SteemDollars": "스팀달러", "Sei": "세이", "HUNT": "헌트", "Strike": "스트라이크", "Cosmos": "코스모스", "Cronos": "크로노스", "SPACE ID": "스페이스아이디", "NEO": "네오", "Hive": "하이브", "Lisk": "리스크", "Status Network Token": "스테이터스네트워크토큰", "Moss Coin": "모스코인", "Blur": "블러", "QuarkChain": "쿼크체인", "IQ.wiki": "아이큐", "Mask Network": "마스크네트워크", "Immutable X": "이뮤터블엑스", "NEAR Protocol": "니어프로토콜", "Power ledger": "파워렛저", "Sentinel Protocol": "센티넬프로토콜", "Ada": "에이다", "Ardor": "아더", "Groestlcoin": "그로스톨코인", "IOST": "아이오에스티", "Waves": "웨이브", "Icon": "아이콘", "Astar": "아스타", "SXP": "솔라", "Solana": "솔라나", "FirmaChain": "피르마체인", "Algorand": "알고랜드", "Standard Tokenization Protocol": "에스티피", "Pyth Network": "피스네트워크", "ZetaChain": "제타체인", "Hifi Finance": "하이파이", "Ankr": "앵커", "Bitcoin SV": "비트코인에스브이", "MultiversX": "멀티버스엑스", "Decentraland": "디센트럴랜드", "MovieBloc": "무비블록", "MVL": "엠블", "Aave": "에이브", "Ontology": "온톨로지", "Siacoin": "시아코인", "Aptos": "앱토스", "Shiba Inu": "시바이누", "Qtum": "퀀텀", "Ark": "아크", "Stepn": "스테픈", "Sui": "수이", "Tokamak Network": "토카막네트워크", "Chiliz": "칠리즈", "Mantle": "맨틀", "Axie Infinity": "엑시인피니티", "Aergo": "아르고", "Flow": "플로우", "Hedera": "헤데라", "Theta Fuel": "쎄타퓨엘", "Polygon": "폴리곤", "Lumen": "스텔라루멘", "Bitcoin Gold": "비트코인골드", "0x Protocol": "제로엑스", "The Graph": "더그래프", "EOS": "이오스", "Bitcoin Cash": "비트코인캐시", "Chainlink": "체인링크", "Carry Protocol": "캐리프로토콜", "Orbs": "오브스", "Ethereum": "이더리움", "Loom Network": "룸네트워크", "Mina": "미나", "Alpha Quark Token": "알파쿼크", "Arbitrum": "아비트럼"]
        return coins[englishName]!
    }
}
