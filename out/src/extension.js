'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = activate;
exports.generateCapnpID = generateCapnpID;
exports.deactivate = deactivate;
const vscode = require("vscode");
const capnpid = require("capnpid");
function activate(context) {
    const disposable = vscode.commands.registerCommand('extension.generateCapnpID', () => {
        generateCapnpID();
    });
    context.subscriptions.push(disposable);
}
function generateCapnpID() {
    const editor = vscode.window.activeTextEditor;
    if (!editor) {
        vscode.window.showErrorMessage('No active editor');
        return;
    }
    const capnpidline = capnpid.newCapnpID() + "\n";
    editor.edit(editBuilder => {
        editBuilder.insert(new vscode.Position(0, 0), capnpidline);
    });
}
function deactivate() { }
//# sourceMappingURL=extension.js.map