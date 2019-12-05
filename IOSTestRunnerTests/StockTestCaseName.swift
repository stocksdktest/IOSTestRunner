//
//  StockTestcaseName.swift
//  IOSTestRunnerTests
//
//  Created by liao xiangsen on 2019/8/25.
//  Copyright © 2019年 liao xiangsen. All rights reserved.
//

#if !swift(>=4.2)
    public protocol CaseIterable {
        associatedtype AllCases: Collection where AllCases.Element == Self
        static var allCases: AllCases { get }
    }
    extension CaseIterable where Self: Hashable {
        static var allCases: [Self] {
            return [Self](AnySequence { () -> AnyIterator<Self> in
                var raw = 0
                var first: Self?
                return AnyIterator {
                    let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                    if raw == 0 {
                        first = current
                    } else if current == first {
                        return nil
                    }
                    raw += 1
                    return current
                }
            })
        }
    }
#endif

enum StockTestCaseName: String, CaseIterable {
    case QUOTE_REQUEST_EXAMPLE = "TESTCASE_0"
    case SnapQuoteTestCase = "SnapQuoteTestCase"
    case PlateIndexQuoteTestCase = "PlateIndexQuoteTestCase"
    case AHQuoteListTestCase1 = "AHQuoteListTestCase1"
    case AHQuoteListTestCase2 = "AHQuoteListTestCase2"
    case AHQuoteTestCase = "AHQuoteTestCase"
    case QuoteTestCase = "QuoteTestCase"
    case ChartTestCase = "ChartTestCase"
    case AddValueTestCase = "AddValueTestCase"
    case MAddValuetTestCase = "MAddValuetTestCase"
    case OfferQuoteListTestCase = "OfferQuoteListTestCase"
    case OfferQuoteTestCase = "OfferQuoteTestCase"
    case TradeQuoteTestCase = "TradeQuoteTestCase"
    case HKPriceDiffTestCase = "HKPriceDiffTestCase"
    case HSAmountTestCase = "HSAmountTestCase"
    case TradeDateTestCase = "TradeDateTestCase"
    case SubnewBondRankingTestCase = "SubnewBondRankingTestCase"
    case SubnewStockRankingTestCase = "SubnewStockRankingTestCase"
    case DRQuoteListTestCase = "DRQuoteListTestCase"
    case DRlinkTestCase = "DRlinkTestCase"
    case ChartIndexTestCase = "ChartIndexTestCase"
    case HKMarketInfoTestCase = "HKMarketInfoTestCase"
    case StaticDataTestCase = "StaticDataTestCase"
    case MarketHolidayTestCase = "MarketHolidayTestCase"
    case HKQuoteInfoTestCase = "HKQuoteInfoTestCase"
    case OrderQuantityTestCase = "OrderQuantityTestCase"
    case PriceVolumeTestCase = "PriceVolumeTestCase"
    case EventTestCase = "EventTestCase"
    case OptionTTestCase = "OptionTTestCase"
    case OptionTestCase = "OptionTestCase"
    case ExpireMonthTestCase = "ExpireMonthTestCase"
    case UnderlyingStockTestCase = "UnderlyingStockTestCase"
    case SearchTestCase = "SearchTestCase"
    case OHLCV2TestCase = "OHLCV2TestCase"
    case OHLCTestCase = "OHLCTestCase"
    case BidChartTestCase = "BidChartTestCase"
    case HistoryChartTestCase = "HistoryChartTestCase"
    case AfterHoursChartTestCase = "AfterHoursChartTestCase"
    case CategorySortingTestCase_1 = "CategorySortingTestCase_1"
    case CategorySortingTestCase_2 = "CategorySortingTestCase_2"
    case CategoryQuoteListTestCase = "CategoryQuoteListTestCase"
    case SectionQuoteTestCase = "SectionQuoteTestCase"
    case SectionSortingTestCase_1 = "SectionSortingTestCase_1"
    case SectionSortingTestCase_2 = "SectionSortingTestCase_2"
    case MarketUpdownsTestCase = "MarketUpdownsTestCase"
    case CompoundUpdownsTestCase = "CompoundUpdownsTestCase"
    case IndexUpdownsTestCase = "IndexUpdownsTestCase"
    case  LinkQuoteTestCase = "LinkQuoteTestCase"
    case  UKQuoteTestCase = "UKQuoteTestCase"
    case TimeTickTestCase = "TimeTickTestCase"
    case OverLayChartTestCase = "OverLayChartTestCase"
    case OHLCSubTestCase = "OHLCSubTestCase"
    case L2TimeTickTestCase = "L2TimeTickTestCase"
    case L2TimeTickDetailTestCase = "L2TimeTickDetailTestCase"
    case SearchV2TestCase = "SearchV2TestCase"
    case VolumeTestCase = "VolumeTestCase"
//    ///////////////////F10//////////////
    case  F10TestCase = "F10TestCase"
    case  LatestIndexTestCase = "LatestIndexTestCase"
    case  BigEventNotificationTestCase = "BigEventNotificationTestCase"
    case  BonusFinanceTestCase = "BonusFinanceTestCase"
    case  TradeDetailInfoTestCase = "TradeDetailInfoTestCase"
    case  ForecastYeareTestCase = "ForecastYeareTestCase"
    case  ForecastRatingTestCase = "ForecastRatingTestCase"
    case  CompanyInfoTestCase = "CompanyInfoTestCase"
    case  CoreBusinessTestCase = "CoreBusinessTestCase"
    case  LeaderPersonInfoTestCase = "LeaderPersonInfoTestCase"
    case  FinancialSummaryTestCase = "FinancialSummaryTestCase"
    case  FinancialInfoTestCase = "FinancialInfoTestCase"
    case  StockShareInfoTestCase = "StockShareInfoTestCase"
    case  StockShareChangeInfoTestCase = "StockShareChangeInfoTestCase"
    case  ShareHolderHistoryInfoTestCase = "ShareHolderHistoryInfoTestCase"
    case  TopLiquidShareHolderTestCase = "TopLiquidShareHolderTestCase"
    case  TopShareHolderTestCase = "TopShareHolderTestCase"
    case  FundShareHolderInfoTestCase = "FundShareHolderInfoTestCase"
    case  NewsListTestCase = "NewsListTestCase"
    case  NewsTestCase = "NewsTestCase"
    case  StockBulletinListTestCase = "StockBulletinListTestCase"
    case  StockBulletinTestCase = "StockBulletinTestCase"
    case  StockNewsListTestCase = "StockNewsListTestCase"
    case  StockNewsTestCase = "StockNewsTestCase"
    case  StockReportListTestCase = "StockReportListTestCase"
    case  StockReportTestCase = "StockReportTestCase"
    case  IPODateTestCase = "IPODateTestCase"
    case  IPOCalendarTestCase = "IPOCalendarTestCase"
    case  IPOShareDetailTestCase = "IPOShareDetailTestCase"
    case  FundValueTestCase = "FundValueTestCase"
    case  FundBasicInfoTestCase = "FundBasicInfoTestCase"
    case  FundNetValueTestCase = "FundNetValueTestCase"
    case  FundAssetAllocationTestCase = "FundAssetAllocationTestCase"
    case  FundIndustryPortfolioTestCase = "FundIndustryPortfolioTestCase"
    case  FundStockPortfolioTestCase = "FundStockPortfolioTestCase"
    case  FundShareStructTestCase = "FundShareStructTestCase"
    case  FundFinanceTestCase = "FundFinanceTestCase"
    case  FundDividendTestCase = "FundDividendTestCase"
    case  BondBasicInfoTestCase = "BondBasicInfoTestCase"
    case  BondInterestPayTestCase = "BondInterestPayTestCase"
    case  BondBuyBacksTestCase = "BondBuyBacksTestCase"
    case  GradeFundTestCase = "GradeFundTestCase"
    case  MarginInfoTestCase = "MarginInfoTestCase"
    case  MarginInfoDiffTestCase = "MarginInfoDiffTestCase"
    case  MarginInfoShareTestCase = "MarginInfoShareTestCase"
    case BlockTradeTestCase = "BlockTradeTestCase"
    case BrokerSeatTestCase = "BrokerSeatTestCase"
    static func fromString(_ str: String) -> StockTestCaseName? {
        return self.allCases.first{ $0.rawValue == str }
    }
}
