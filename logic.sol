// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "IERC20.sol";
import "Ownable.sol";

contract UPSLocker is  Ownable {
    struct Users_bal {
        uint256 balance;
    }

    //代币地址
    address public token_address;
    uint256 public last_date;
    uint256 public tax_fees;
    address payable public tax_account;

    mapping(address => Users_bal) public users;

    event claimUnit(address claim_address, uint256 amount, uint256 tax_amt);
    event burnToken(uint256 amount);

    constructor(address _token_add)  {
        token_address = _token_add;
        last_date = 1649548800;
        tax_fees = 40000000; // 40 trx tax
        tax_account = 0x169eA82ffa06fb686EF3A0753b34Da336789B7DE;

        // TF1qWixCorPRPRLNHNoWs3DgEgSHBudmLB
        user[0x3757F067994415012e1257e38188e27CB4796f2B].balance= 21939287;
        // TYyVFHubuVXMFbNScW4Bz1mCHz89w54o7e
        user[0xFC587439b5290e1C9d050ea3B7A0C62cCA818dCB].balance= 1437289295846;
        // TWtRqFxnjGhq8avMtWucCgiMajhzHk7XDZ
        user[0xE57345bfa368926daf5cA1Ff06aE174b773a4Af7].balance= 8760276;
        // TRFnzX3reCiqxXNowZkHmdjEed7XosCzrQ
        user[0xa7ACEA8855584Ea787c3a7e6F0e720cD84621e3c].balance= 6022809082364;
        // TF868RB5q3SL7wtkhcQrTPi2HWHz1GhHBm
        user[0x3886A29AF7dE4767151A4a92AB0F743EDf3d3678].balance= 1304471016123;
        // TB2H93z1HAMCSAhJMo2EoxemZSeAheAwNZ
        user[0x0b8CD3e6F3E9717d4B30af237944408E7473874e].balance= 2253803012936;
        // TL8KtvekamcVqgSaeXQpSHEKafGCXA6NsQ
        user[0x6f6Ac1aBDe27f4C6a5385321EdE8070ffB1991F2].balance= 2550260198021;
        // TPkdzWA4o9hDi3ieDztmukNqHCsRCer3jk
        user[0x973136e47bC4cB3a65B12dF9a37EF340623B7675].balance= 2677096069030;
        // TSdvWmkC7ww5w3uu5B6iYyanNaUvqvEmzq
        user[0xb6d478C883Bcb01770649036E63F0A704fB16760].balance= 536429496632;
        // TSAHgYHaUHCczVtNsWNk6duFpj4PqWBHpM
        user[0xb19a7Ed145DF956156251F0Ea40c2452B5279E88].balance= 1394522150934;
        // TWF2K5XLEQzY1qWg4xSkmW1RMSrZC6hhvG
        user[0xDe603f81CD5e6F76626C3C15f73Aa6261533b138].balance= 4681928430735;
        // TSSRQoAyZB2xEUTnyc15DSg3eBqs3Fctq4
        user[0xb4A79a2cfC84257c3e19CE12187c5a69145A0C10].balance= 3340935623355;
        // TSQeVFEsgre12ZUtqcRtRmZHyxDLUFQ7ru
        user[0xb451afabe7BA3cA6Fc4d800EccCB8F0a7C64FA62].balance= 3290831144503;
        // TTunv5xpsRbUZA5dqZZcVKq97ELW5F3AUA
        user[0xc4ccE91425d6C79216C7e987ae5CAb4EC4433141].balance= 3175226191802;
        // TViA69EiGZcTkLEWyDKGz92cGSrax3Z4CA
        user[0xd889d85b4d3385ebf44b7a92c4642Dec14f44812].balance= 2150362202498;
        // TLrgokc6gTc61cn7JhTd19LwcXW95bq5SK
        user[0x776DAeB0E013e535530ab943Da16C5582a17A160].balance= 1984428347719;
        // TMpJQ4KeE8xnxJA6YvVjq1AmhfUdi22iyw
        user[0x81F24542cCFc53250b37384DE9DFA97eFeA57F47].balance= 2755643804459;
        // THfFZyYvRbCRWbkKKZxzCYVJh3kXYrKZVt
        user[0x545bA9879956Cc81112AC4A8a2a424d062222db8].balance= 1078666943295;
        // TTb3xDqyJeJPbM2naz5WmiNhjepPGRJZWB
        user[0xC1418f2E43e032464E8F0F1310B36230484Fd6A0].balance= 972996787658;
        // TJ3WeuhZjGnitFhhfzzkwVmoa9AJxqcBWU
        user[0x589167DfeA1586b9202ff49935382d9983eB705e].balance= 1718732918461;
        // TCfkHMY59neDX9jrbpS79LCnPBHSunZEHJ
        user[0x1D9B0087d1C2ad606D35fEC52D51D693aF80e1b2].balance= 305852653059;
        // TXFSisCmQZ8bmqP5qEvWwq7U9sSveXvuJa
        user[0xE96CC01aD090F9367914294121D944B50d53e428].balance= 3788832312110;
        // TJiuokr5JPGTC7SqxGxMvzWZxkkqjomVNN
        user[0x6004F47D5c03cdd14d955D8a7C7f5af5dACe4043].balance= 751103662;
        // TP6BEmovP76KpBgQGrydtkJQQdRiw5keEK
        user[0x8FEB1325542e3237E1C23B580Ad207601275422F].balance= 205582060971;
        // TUbHAheM5tryjJZAJ4dVLoW55cMpL1ccKh
        user[0xcC44B76f6abAEC2f472146D3A23bE00a610A9f7C].balance= 303763954501;
        // TY5o8ECAyrt1kdThR7uaYLRgoXQ7QYHTPq
        user[0xf291bf7Acc1272C45B88c6e2a5f5190d5423a665].balance= 112709012848;
        // TBvKz297izMkuxSTxr6ahTKfn2NFry5GKt
        user[0x1564D500a3Ef217Da6506faa2A1587D064Af41D6].balance= 7082546805394;
        // TNgGiK7YY8DmNTMvvzgF3ZfozQkKsdFzV1
        user[0x8B65a96f7b0F8b5bcC34f1B60A62D164dC24Cf03].balance= 71045796383;
        // TKcxBEytQfDnoZDY6gR14gEmJ59PBf8oEy
        user[0x69dC90546cBA0253feadA4c690c1A110739829D6].balance= 1028946536533;
        // TSiJctwouwqLtzMVada3AUZxKPAC69ZtQV
        user[0xB7a896A6292F2d2aedf81F8620e8A5b9E6c94D63].balance= 95761497686;
        // TH5VW25NPa3ZGPhcroUK2uU4KoZNfYXhWX
        user[0x4Df926318325C3ab1a00b18441Ac8DBC843e3513].balance= 95095270179;
        // TCDwZmHwsL1ZqavzfsrVxpcBXtMEAmfjwp
        user[0x18B99b0711421FF28AE9a426a015f411Ab12C349].balance= 315767043254;
        // TZ3vB39jafFDX372oAnFw1ZWjANMsQmQbM
        user[0xfD2EECf230C8e60900523b245555f2F3aBC23805].balance= 93028341294;
        // TXjQTc8XwYCn5qmDkJsr1U9v6cHGzBPf4P
        user[0xEeB682193941592ed3a9D1474f517bE63A362F25].balance= 38600309219;
        // TPtTWwQKpmzyuPSaktJp4SLUdy3VvTyGtm
        user[0x98ABcC3Db546Ee85e45dAAB5E4191540C39Dfdd0].balance= 63936587;
        // TJsVwHSupWU52fqQ7FeyaMookMDuSwZWpi
        user[0x61A4C5d907E9111bdEbA153eE23c4ebA253e403B].balance= 65309651;
        // THje5aKFPaL3hKK5qTV78AuJgghmipbL6p
        user[0x55301DE3896237C0ae78947AA01B4cD3ae808515].balance= 58727319;
        // TCtbswN4hyQ34e8q5U1pziNuHQ7Dz7xArU
        user[0x200964fd3B5e3379aDE064fc2F868d41f44b5c3b].balance= 63436877;
        // TJACJiyYSbNg5Y6b4qBi9xuHkSbHSL33gH
        user[0x59d50057df39f864DF5d3b410c3232B58327B5f6].balance= 997754419598;
        // TQqHRW7XHHVLsktkSYXSWjgzFx7QnDLmYc
        user[0xa30A3fF95090406f5DaA64f410611ABdF15dfD49].balance= 64946046;
        // TGNH7XGbS1M7YLGxxZa5XtQ4DM2YUtKBeY
        user[0x462dc0fe83FBbA4E9B928874457bF814A8b532ce].balance= 218387226371;
        // TNvs4WZTQNVSjU2VtdAV3thB4ivcyZRci9
        user[0x8e282864575806f5e1467fA6ab3c4606b1f544Eb].balance= 3752350072829;
        // TTo5LSEh7mF6KpNp2sYVHGJqfp4qRxKYNp
        user[0xc387b48EF5e7571EC36dcE990d92E09959b177BE].balance= 203996662113;
        // TUhqvKmZTm8XfbDomsBMAyAnnvnxt8TyGa
        user[0xCD828d6A75B38b4B1ceCf24dEe9ea4c665ad868F].balance= 1132540274480;
        // TRiKZDcDcDH21x5xrAQBvWHxKMoS2wHVCk
        user[0xacb13E981C1142D23742F0BAE754729f7086F69d].balance= 5830538119898;
        // TFT4J9siPMq8KiVNgimoEE6RrTPNSxJZp4
        user[0x3c1D0251EB9e64ACD3539d1e5b2cb3611002AD06].balance= 197574115334;
        // TKGw5iC6FuwuQ95ok8sxdjbrbGVbNxHdaH
        user[0x661354877BC7B8fdA7b96D3fE5639ecf969D434D].balance= 141484690611;
        // TCwjh2zEXPwzpMRgxggiXEcnrCsx7A7xWw
        user[0x20a129dc465B161F44c570aA648374d9dE02B001].balance= 280881362256;
        // TNe1fig6eQSwURDUe2PrAhY5xE9xRsQfyg
        user[0x8af8456F937B1d5693C250Efe3A42BF3375d5A3a].balance= 149950168999;
        // TVv2avVgtmJNR36w8GtsBo9o1thn1CZB6C
        user[0xDAc892a5849BD377c4Dc5c127f72c77d9652B5E6].balance= 1196254656227;
    }

    // 此合约剩余代币数量
    function balanceOf() view external returns (uint256 _amount){
        return (IERC20(token_address).balanceOf(address(this)));
    }
    // 用户能领取的数额
    function balanceOfUser(address _user_address) view external returns (uint256 _amount){
        return (users[_user_address].balance);
    }
    // 用户能领
    function ClaimUser(address _user_address)payable external returns(bool){
        require(block.timestamp <= last_date, 'Claim already expired');
        require(msg.value >= tax_fees, 'Not enough Tax fees');

        uint256 bal = users[_user_address].balance;
        require(bal > 0, 'Issufficient funds for claim');

        payable(tax_account).transfer(tax_fees);
        IERC20(token_address).transfer(_user_address, bal);

        users[_user_address].balance = 0;
        emit claimUnit(_user_address, bal, tax_fees);
        return true;
    }

    // 燃烧代币
    function BurnAll () external onlyOwner returns(bool){
        require(block.timestamp >= last_date, 'Claim have not expired');
        uint256 amt_left = IERC20(token_address).balanceOf(address(this));

        IERC20(token_address).burn(amt_left);
        emit burnToken(amt_left);
        return true;
    }
}