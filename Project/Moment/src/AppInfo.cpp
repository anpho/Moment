/*
 * AppInfo.cpp
 *
 *  Created on: 2012-12-27
 *      Author: MMMOOO
 */

#include "AppInfo.h"
#include <bb/ApplicationInfo>
#include <bb/device/HardwareInfo>
#include <bb/platform/PlatformInfo>
#include <bb/device/SimCardInfo>
//#include <bb/device/CellularNetworkInfo>
using namespace bb;
using namespace bb::device;
using namespace bb::platform;

AppInfo::AppInfo(QObject* parent) :
		QObject(parent) {
	// TODO Auto-generated constructor stub

}

AppInfo::~AppInfo() {
}

QString AppInfo::getVersion() {
	ApplicationInfo info;
	return info.version();
}

QString AppInfo::getSerialNumber() {
	HardwareInfo info;
	QString pinS=info.pin();
	pinS=pinS.right(8);
	return pinS;
}

QString AppInfo::getModelNumber() {
	HardwareInfo info;
	return info.modelNumber();
}

QString AppInfo::getHardwareModel() {
	HardwareInfo info;
	return info.modelName();
}

QString AppInfo::getSystemInfo() {
	PlatformInfo info;
	return info.osVersion();
}
