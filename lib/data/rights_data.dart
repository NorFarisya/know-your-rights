
import '../models/rights_issue.dart';

// Here will store all the rights information used in the app
// The information is first written here so later the screens can just
// retrieve and display it without repeating the same content in the UI

// A constant list is used because the rights information is prepared
// in advance and won t need to change while the application is running.
// Each RightsIssue object represents one common rights-related problem.

const List<RightsIssue> rightsIssues = [
  // 1. EMPLOYMENT RIGHTS - UNPAID SALARY
  RightsIssue(
    // These fields are the issues and give a short description
    // that will show on the Explore Rights screen.
    title: 'Unpaid Salary',
    category: 'Employment',

    description:
        'Learn what actions employees can take when wages are delayed.',

    // Explains the problem so users can understand the situation
    // before reading about their legal rights.
    problemOverview:
        'Unpaid salary occurs when an employee does not receive '
        'their wages by the required payment deadline or is not '
        'paid the amount lawfully owed.',

    // A list is used because each issue can have several rights.
    // These points are based on the Employment Act 1955,
    // Section 19(1)-(3).
    rights: [
      'Employers must generally pay wages within 7 days '
          'after the wage period ends.',

      'Rest day, public-holiday and overtime wages have '
          'a different payment deadline.',

      'The Director General of Labour may approve an '
          'extension of the payment deadline.',
    ],

    // Provides practical steps that users can follow
    // if they are experiencing an unpaid salary problem.
    // The steps are based on JTKSM guidance and general recommendations.
    nextSteps: [
      'Check your employment contract and salary payment dates.',

      'Keep payslips, bank records and employment documents.',

      'Contact your employer to request clarification or payment.',

      'If unresolved, consider filing a complaint with JTKSM.',
    ],

    // Lists down the government agency where users can seek assistance
    agencyName:
        'Jabatan Tenaga Kerja Semenanjung Malaysia (JTKSM)',

    agencyDescription:
        'JTKSM handles employment-related complaints, '
        'including breaches of employment terms and conditions.',

    // LegalSource objects store the reference title, description
    // and URL together. This helps to makes it easier by displaying the sources
    // and allow users to access the original information.
    sources: [
      LegalSource(
        title: 'Employment Act 1955 (Act 265)',
        description:
            'Section 19(1)-(3): Time of Payment of Wages',
        url:
            'https://www.investmalaysia.gov.my/media/felj30g0/employment-act-1955.pdf',
      ),

      LegalSource(
        title: 'JTKSM - Official Complaints Guidance',
        description:
            'Information about employment complaints '
            'and supporting documents.',
        url:
            'https://jtksm.gov.my/ms/perkhidmatan/aduan',
      ),
    ],
  ),


  // 2. CONSUMER RIGHTS - FAULTY PRODUCT
  RightsIssue(
    title: 'Faulty Product',
    category: 'Consumer',

    //  This  description will appear on the Explore Rights screen

    description:
        'Understand your options when a purchased item is defective.',

    // Describes common situations involving defective or unsafe goods.
    // Based on the Consumer Protection Act 1999, Section 32.
    problemOverview:
        'A faulty product may be defective, unsafe, or unable '
        'to function as reasonably expected. Consumers may '
        'have legal remedies depending on the nature of the problem.',

    // Lists the main consumer protections related to faulty goods.
    // Each point is based on the relevant provisions of Act 599.
    rights: [
      // Section 32(1)-(2): Acceptable quality of goods.
      'Goods supplied to consumers must meet acceptable '
          'quality standards, including safety and durability.',

      // Section 41(1)(a): Remedy for certain failures.
      'Consumers may require suppliers to remedy certain '
          'defects within a reasonable time.',

      // Sections 45 and 46(1): Rights to reject eligible goods.
      'If legally entitled to reject faulty goods, '
          'consumers may choose a refund or an eligible replacement.',
    ],

    // Gives the users simple actions to take when they receive
    // a defective product and tells them to keep evidence of the problem.
    nextSteps: [
      'Keep the purchase receipt and photograph the defect.',

      'Contact the seller and explain the problem.',

      'Request an appropriate remedy based on the defect.',

      'If unresolved, consider filing an eligible claim with TTPM.',
    ],

    // Identifies the tribunal that handles eligible consumer claims.
    agencyName:
        'Tribunal Tuntutan Pengguna Malaysia (TTPM)',

    agencyDescription:
        'TTPM provides a forum for eligible consumer claims '
        'involving goods and services. Claims are subject to '
        'the tribunal\'s jurisdiction and requirements.',

    // Stores the legislation and official tribunal guidance
    // so users can refer to the original sources.
    sources: [
      LegalSource(
        title: 'Consumer Protection Act 1999 (Act 599)',
        description:
            'Sections 32, 41, 45 and 46: Consumer guarantees '
            'and remedies for faulty goods.',
        url:
            'https://www.kpdn.gov.my/images/2024/awam/akta/ttpm/Act%20599.pdf',
      ),

      LegalSource(
        title: 'TTPM - Official Consumer Claims Guidance',
        description:
            'Information about eligible consumer claims '
            'and tribunal procedures.',
        url:
            'https://ttpm.kpdn.gov.my/soalan-lazim.html',
      ),
    ],
  ),


  // 3. DIGITAL RIGHTS - ONLINE SCAM
  

  RightsIssue(
    title: 'Online Scam',
    category: 'Digital',


    description:
        'Find out what to do if you believe you were scammed online.',

    // Explains how scammers use digital platforms to deceive people.
    // The legal background is based on Penal Code Sections 415 and 420.
    problemOverview:
        'An online scam occurs when someone uses deception '
        'through digital platforms to obtain money, property '
        'or sensitive information from another person.',

    // Shows the legal protection and reporting options available
    // to people who have experienced an online scam.
    rights: [

      // Penal Code (Act 574), Section 420.
      
      'Dishonestly deceiving someone into handing over '
          'property may be an offence under Section 420 '
          'of the Penal Code.',

      // Based on Bank Negara Malaysia financial scam guidance.
      'Victims of financial scams can report the incident '
          'to their bank or NSRC at 997.',

      // Users can also report suspected criminal activity to the police.
      'Suspected scams can be reported to the police '
          'for investigation.',
    ],

    // Lists the recommended actions users should take after
    // finding out that they may have been scammed.

    nextSteps: [
      // Contacting the bank or NSRC quickly is important
      // when money has been transferred or lost.

      'Immediately contact your bank or NSRC at 997 '
          'if money is involved.',

      'Lodge a police report as soon as possible.',

      // Keeping evidence can help support the investigation.
      'Keep transaction records, messages and '
          'screenshots as evidence.',

      'Secure affected accounts and avoid sharing '
          'further personal information.',
    ],

    // NSRC is included as the main contact point for
    // reporting recent financial scams.
    agencyName:
        'National Scam Response Centre (NSRC)',

    agencyDescription:
        'Call 997 to report a recent financial scam. '
        'You should also contact your bank and lodge '
        'a police report.',

    // Includes the relevant legislation and official reporting
    // resources so users can find more detailed information.
    sources: [
      LegalSource(
        title: 'Penal Code (Act 574)',
        description:
            'Sections 415 and 420: Cheating and '
            'dishonestly inducing delivery of property.',
        url:
            'https://www.rmp.gov.my/laman-utama/peringatan/'
            'alert-peringatan/2021/11/12/'
            'besmartstayalert-posting-pilihan-scam-alert-awas%21'
            '-jenayah-tipu-boleh-didakwa-di-bawah-seksyen-420'
            '-kanun-keseksaan',
      ),

      LegalSource(
        title:'Bank Negara Malaysia - Financial Scams',
        description:
            'Official guidance on reporting financial '
            'scams to banks, NSRC and the police.',
        url:
            'https://www.bnm.gov.my/faqs/scams',
      ),

      LegalSource(
        title:'NSRC - Official Government Guidance',
        description:
            'Information about scam reporting '
            'and the NSRC 997 hotline.',
        url:
            'https://www.malaysia.gov.my/en/categories/'
            'safety-community-and-law--order/'
            'cybersecurity/nsrc-997-hotline',
      ),

      LegalSource(
        title:'BNM - Unauthorized Transactions',
        description:
            'Additional banking safety guidance '
            'and protective measures.',
        url:
            'https://www.bnm.gov.my/faqs/banking/unauthorised-tx',
      ),
    ],
  ),


  // 4. HOUSING RIGHTS - RENTAL DEPOSIT DISPUTE

  RightsIssue(
    title: 'Rental Deposit Dispute',
    category: 'Housing',

    description:
        'Explore common steps for resolving rental deposit concerns.',

    // Explains the disagreement between a landlord and tenant
    // when part or all of a rental deposit is withheld

    problemOverview:
        'A rental deposit dispute occurs when a landlord '
        'withholds all or part of a tenant\'s deposit and '
        'the tenant disagrees with the deduction or reason given.',

    // List down the main contractual rights and possible legal remedies.
    // Based on the Contracts Act 1950 and Rules of Court 2012.
    rights: [
    // Deposit conditions are generally based on the tenancy agreement.
      'Deposit refunds and deductions depend on the '
          'tenancy agreement and applicable law.',

      // Contracts Act 1950, Section 74(1)-(2).
      // Compensation depends on whether the loss is legally recoverable.
      'Compensation may be available if a breach of '
          'contract causes a legally recoverable loss.',

      // Eligible claims may be brought through civil court procedures.
      'Eligible disputes may be pursued through '
          'civil court procedures, including small claims.',
    ],

    // Suggests practical steps that tenants can follow
    // before deciding whether to pursue a legal claim.
    nextSteps: [
      'Review your tenancy agreement and deposit conditions.',

      'Keep receipts, property photos and relevant messages.',

      'Request a written explanation of any deductions.',

      'If unresolved, consider an appropriate civil claim.',
    ],

    // Identifies the Malaysian Judiciary as the main place
    // where eligible landlord-tenant civil disputes can be pursued.
    agencyName:
        'Malaysian Judiciary - Civil Courts',

    agencyDescription:
        'Landlord-tenant disputes may be handled as civil '
        'claims. Eligible individual claims up to RM5,000 '
        'may use the Small Claims procedure.',

    // Stores the legal provision and official court guidance
    // related to contractual disputes and small claims.
    sources: [
      LegalSource(
        title: 'Contracts Act 1950 (Act 136)',
        description:
            'Section 74(1)-(2): Compensation for loss '
            'or damage caused by breach of contract.',
        url:
            'https://mylaw.my/legislation/'
            'contracts-act-1950/section-74',
      ),

      LegalSource(
        title: 'Malaysian Judiciary - Civil Claims',
        description:
            'Official guidance on civil claims, '
            'including landlord-tenant disputes.',
        url:
            'https://www.kehakiman.gov.my/ms/node/949',
      ),

      LegalSource(
        title: 'Selangor Judiciary - Small Claims Procedure',
        description:
            'Order 93 of the Rules of Court 2012: '
            'Small Claims procedure for eligible '
            'claims up to RM5,000.',
        url:
            'https://selangor.kehakiman.gov.my/en/node/1340',
      ),
    ],

  ),

];
