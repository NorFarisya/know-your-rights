
import '../models/rights_issue.dart';

// KNOW YOUR RIGHTS
// Hard-coded rights information for Practical 1.
// Information is based on Malaysian legislation
// and official government guidance.

const List<RightsIssue> rightsIssues = [

  // ==========================================
  // 1. EMPLOYMENT RIGHTS - UNPAID SALARY
  // ==========================================

  RightsIssue(
    title: 'Unpaid Salary',
    category: 'Employment',

    // Short description shown on Explore Rights.
    description:
        'Learn what actions employees can take when wages are delayed.',

    // PROBLEM OVERVIEW
    problemOverview:
        'Unpaid salary occurs when an employee does not receive '
        'their wages by the required payment deadline or is not '
        'paid the amount lawfully owed.',

    // WHAT ARE YOUR RIGHTS?
    // Employment Act 1955, Section 19(1)-(3).
    rights: [
      'Employers must generally pay wages within 7 days '
          'after the wage period ends.',

      'Rest day, public-holiday and overtime wages have '
          'a different payment deadline.',

      'The Director General of Labour may approve an '
          'extension of the payment deadline.',
    ],

    // SUGGESTED NEXT STEPS
    // Based on JTKSM complaint guidance and
    // general practical recommendations.
    nextSteps: [
      'Check your employment contract and salary payment dates.',

      'Keep payslips, bank records and employment documents.',

      'Contact your employer to request clarification or payment.',

      'If unresolved, consider filing a complaint with JTKSM.',
    ],

    // WHERE TO SEEK HELP
    agencyName:
        'Jabatan Tenaga Kerja Semenanjung Malaysia (JTKSM)',

    agencyDescription:
        'JTKSM handles employment-related complaints, '
        'including breaches of employment terms and conditions.',

    // VERIFIED LEGAL REFERENCES AND OFFICIAL GUIDANCE
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


  // ==========================================
  // 2. CONSUMER RIGHTS - FAULTY PRODUCT
  // ==========================================

  RightsIssue(
    title: 'Faulty Product',
    category: 'Consumer',

    // Short description shown on Explore Rights.
    // Kept unchanged to preserve the existing UI.
    description:
        'Understand your options when a purchased item is defective.',

    // PROBLEM OVERVIEW
    // Consumer Protection Act 1999, Section 32.
    problemOverview:
        'A faulty product may be defective, unsafe, or unable '
        'to function as reasonably expected. Consumers may '
        'have legal remedies depending on the nature of the problem.',

    // WHAT ARE YOUR RIGHTS?
    // Consumer Protection Act 1999, Sections 32, 41, 45 and 46.
    rights: [
      // Section 32(1)-(2)
      'Goods supplied to consumers must meet acceptable '
          'quality standards, including safety and durability.',

      // Section 41(1)(a)
      'Consumers may require suppliers to remedy certain '
          'defects within a reasonable time.',

      // Sections 45 and 46(1)
      'If legally entitled to reject faulty goods, '
          'consumers may choose a refund or an eligible replacement.',
    ],

    // SUGGESTED NEXT STEPS
    // Based on statutory remedies, TTPM guidance and
    // practical evidence-preservation recommendations.
    nextSteps: [
      'Keep the purchase receipt and photograph the defect.',

      'Contact the seller and explain the problem.',

      'Request an appropriate remedy based on the defect.',

      'If unresolved, consider filing an eligible claim with TTPM.',
    ],

    // WHERE TO SEEK HELP
    agencyName:
        'Tribunal Tuntutan Pengguna Malaysia (TTPM)',

    agencyDescription:
        'TTPM provides a forum for eligible consumer claims '
        'involving goods and services. Claims are subject to '
        'the tribunal\'s jurisdiction and requirements.',

    // LEGAL REFERENCES AND OFFICIAL GUIDANCE
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



  // ==========================================
  // 3. DIGITAL RIGHTS - ONLINE SCAM
  // ==========================================

  RightsIssue(
    title: 'Online Scam',
    category: 'Digital',

    // Short description shown on Explore Rights.
    // Kept unchanged to preserve the existing UI.
    description:
        'Find out what to do if you believe you were scammed online.',

    // PROBLEM OVERVIEW
    // Based on the Penal Code Sections 415 and 420.
    problemOverview:
        'An online scam occurs when someone uses deception '
        'through digital platforms to obtain money, property '
        'or sensitive information from another person.',

    // WHAT ARE YOUR RIGHTS?
    // Penal Code Section 420 and official reporting guidance.
    rights: [
      // Penal Code (Act 574), Section 420.
      'Dishonestly deceiving someone into handing over '
          'property may be an offence under Section 420 '
          'of the Penal Code.',

      // Bank Negara Malaysia - Financial Scams FAQ.
      'Victims of financial scams can report the incident '
          'to their bank or NSRC at 997.',

      // Bank Negara Malaysia and PDRM guidance.
      'Suspected scams can be reported to the police '
          'for investigation.',
    ],

    // SUGGESTED NEXT STEPS
    // Based on BNM and official NSRC guidance.
    nextSteps: [
      'Immediately contact your bank or NSRC at 997 '
          'if money is involved.',

      'Lodge a police report as soon as possible.',

      'Keep transaction records, messages and '
          'screenshots as evidence.',

      'Secure affected accounts and avoid sharing '
          'further personal information.',
    ],

    // WHERE TO SEEK HELP
    agencyName:
        'National Scam Response Centre (NSRC)',

    agencyDescription:
        'Call 997 to report a recent financial scam. '
        'You should also contact your bank and lodge '
        'a police report.',

    // LEGAL REFERENCES AND OFFICIAL GUIDANCE
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
        title: 'Bank Negara Malaysia - Financial Scams',
        description:
            'Official guidance on reporting financial '
            'scams to banks, NSRC and the police.',
        url:
            'https://www.bnm.gov.my/faqs/scams',
      ),

      LegalSource(
        title: 'NSRC - Official Government Guidance',
        description:
            'Information about scam reporting '
            'and the NSRC 997 hotline.',
        url:
            'https://www.malaysia.gov.my/en/categories/'
            'safety-community-and-law--order/'
            'cybersecurity/nsrc-997-hotline',
      ),

      LegalSource(
        title: 'BNM - Unauthorized Transactions',
        description:
            'Additional banking safety guidance '
            'and protective measures.',
        url:
            'https://www.bnm.gov.my/faqs/banking/unauthorised-tx',
      ),
    ],
  ),



  // ==========================================
  // 4. HOUSING RIGHTS - RENTAL DEPOSIT DISPUTE
  // ==========================================

  RightsIssue(
    title: 'Rental Deposit Dispute',
    category: 'Housing',

    // Short description shown on Explore Rights.
    // Kept unchanged to preserve the existing UI.
    description:
        'Explore common steps for resolving rental deposit concerns.',

    // PROBLEM OVERVIEW
    // Based on tenancy agreements and contract law.
    problemOverview:
        'A rental deposit dispute occurs when a landlord '
        'withholds all or part of a tenant\'s deposit and '
        'the tenant disagrees with the deduction or reason given.',

    // WHAT ARE YOUR RIGHTS?
    // Contracts Act 1950, Section 74.
    // Rules of Court 2012, Order 93.
    rights: [
      // Contractual obligations.
      'Deposit refunds and deductions depend on the '
          'tenancy agreement and applicable law.',

      // Contracts Act 1950, Section 74(1)-(2).
      'Compensation may be available if a breach of '
          'contract causes a legally recoverable loss.',

      // Malaysian Judiciary - Civil and Small Claims.
      'Eligible disputes may be pursued through '
          'civil court procedures, including small claims.',
    ],

    // SUGGESTED NEXT STEPS
    // Based on judiciary guidance and practical
    // dispute-resolution recommendations.
    nextSteps: [
      'Review your tenancy agreement and deposit conditions.',

      'Keep receipts, property photos and relevant messages.',

      'Request a written explanation of any deductions.',

      'If unresolved, consider an appropriate civil claim.',
    ],

    // WHERE TO SEEK HELP
    agencyName:
        'Malaysian Judiciary - Civil Courts',

    agencyDescription:
        'Landlord-tenant disputes may be handled as civil '
        'claims. Eligible individual claims up to RM5,000 '
        'may use the Small Claims procedure.',

    // LEGAL REFERENCES AND OFFICIAL GUIDANCE
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
