'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require("vscode");
const capnpid = require("capnpid");
// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    let disposable = vscode.commands.registerCommand('extension.generateCapnpID', () => {
        // The code you place here will be executed every time your command is executed
        generateCapnpID();
        // Display a message box to the user
        // vscode.window.showInformationMessage('Hello World!');
    });
    context.subscriptions.push(disposable);
}
exports.activate = activate;
function generateCapnpID() {
    let capnpidline = capnpid.newCapnpID() + "\n";
    const document = vscode.window.activeTextEditor.document;
    vscode.window.activeTextEditor.edit(editBuilder => {
        editBuilder.insert(new vscode.Position(0, 0), capnpidline);
    });
}
exports.generateCapnpID = generateCapnpID;
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map