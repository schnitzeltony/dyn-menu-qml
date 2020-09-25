import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("DnyMenuQml")

    property int clickCount: 0
    property var dynModel: [ "Dyn Menu Initial"]

    RowLayout { // GUI
        width: parent.width
        Button {
            text: "Open Menu"
            onClicked: {
                dynModel.push("DynMenu " + (++clickCount))
                menu.open()
            }
        }
        Label { text: "Clicks: " + clickCount }
        Label { id: infoLabel }
    }

    Menu { // dyn menu
        id: menu
        MenuItem { // 0
            text: "Static Menu 1"
            onTriggered: infoLabel.text = text
        }
        MenuSeparator { } // 1
        MenuSeparator { } // 2
        MenuItem {
            text: "Static Menu 2"
            onTriggered: infoLabel.text = text
        }
        // js array.push does not cause instantiator to update objects...
        onAboutToShow: { instantiator.model = dynModel }
        Instantiator { // dynamic part - injected before position 2
            id: instantiator
            delegate: MenuItem {
                text: modelData
                onTriggered: infoLabel.text = modelData
            }
            onObjectAdded: menu.insertItem(index + 2, object)
            onObjectRemoved: menu.removeItem(object)
        }
    }
}
