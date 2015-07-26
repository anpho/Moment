/*
 * AppInfo.h
 *
 *  Created on: 2012-12-27
 *      Author: MMMOOO
 */

#ifndef APPINFO_H_
#define APPINFO_H_

#include <QtCore/QObject>

class AppInfo : public QObject{
	Q_OBJECT
public:
	AppInfo(QObject* parent = 0);
	virtual ~AppInfo();

	Q_INVOKABLE QString getVersion();
	Q_INVOKABLE QString getSerialNumber();
	Q_INVOKABLE QString getHardwareModel();
	Q_INVOKABLE QString getSystemInfo();
	Q_INVOKABLE QString getModelNumber();

};

#endif /* APPINFO_H_ */
