/*
    AniLibria - desktop client for the website anilibria.tv
    Copyright (C) 2020 Roman Vladimirov

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import "../Controls"

Page {
    id: authorizePage
    anchors.fill: parent
    background: Rectangle {
        color: applicationThemeViewModel.pageBackground
    }

    signal navigateFrom()
    signal navigateTo()

    onNavigateTo: {
        authorizationViewModel.resetModel();
    }

    RowLayout {
        id: panelContainer
        anchors.fill: parent
        spacing: 0
        Rectangle {
            color: applicationThemeViewModel.pageVerticalPanel
            width: 40
            Layout.fillHeight: true
            Column {
                IconButton {
                    height: 45
                    width: 40
                    overlayVisible: false
                    iconPath: applicationThemeViewModel.iconMainMenu
                    iconWidth: 28
                    iconHeight: 28
                    onButtonPressed: {
                        drawer.open();
                    }
                }
            }
        }
        Rectangle {
            color: "transparent"
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                anchors.fill: parent
                source: assetsLocation.backgroundsPath + "authbackground.jpg"
                fillMode: Image.PreserveAspectCrop
            }

            Rectangle {
                id: fieldsContainer
                radius: 8
                color: applicationThemeViewModel.panelBackground
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 400
                height: 280

                ColumnLayout {
                    id: authForm
                    anchors.fill: parent
                    anchors.margins: 8
                    TextField {
                        id: emailTextBox
                        Layout.fillWidth: true
                        placeholderText: "Логин"
                        text: authorizationViewModel.login
                        onTextChanged: {
                            authorizationViewModel.login = text;
                        }
                    }
                    TextField {
                        id: passwordTextBox
                        Layout.fillWidth: true
                        echoMode: "PasswordEchoOnEdit"
                        placeholderText: "Пароль"
                        text: authorizationViewModel.password
                        onTextChanged: {
                            authorizationViewModel.password = text;
                        }
                    }
                    TextField {
                        id: fa2codeTextBox
                        Layout.fillWidth: true
                        placeholderText: "2fa код (оставить пустым если не настроено)"
                        text: authorizationViewModel.twoFactorCode
                        onTextChanged: {
                            authorizationViewModel.twoFactorCode = text;
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                        height: 40
                        AccentText {
                            text: authorizationViewModel.errorMessage
                            fontPointSize: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            wrapMode: Text.WordWrap
                        }

                        RoundedActionButton {
                            id: saveButton
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            text: "Войти"
                            onClicked: {
                                authorizationViewModel.signin();
                            }
                        }

                        LinkedText {
                            visible: authorizationViewModel.errorMessage.length === 0
                            anchors.top: saveButton.top
                            anchors.topMargin: 10
                            anchors.right: saveButton.left
                            anchors.rightMargin: 6
                            fontPointSize: 10
                            text: authorizationViewModel.registerLink
                        }
                    }
                }
            }
        }
    }

}
