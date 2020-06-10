// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINRAND_QT_BITCOINRANDADDRESSVALIDATOR_H
#define BITCOINRAND_QT_BITCOINRANDADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinrandAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinrandAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Bitcoinrand address widget validator, checks for a valid bitcoinrand address.
 */
class BitcoinrandAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinrandAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // BITCOINRAND_QT_BITCOINRANDADDRESSVALIDATOR_H
