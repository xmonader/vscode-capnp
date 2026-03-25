'use strict';
import * as vscode from 'vscode';
import * as capnpid from 'capnpid';

export function activate(context: vscode.ExtensionContext) {
    const disposable = vscode.commands.registerCommand('extension.generateCapnpID', () => {
        generateCapnpID();
    });

    context.subscriptions.push(disposable);
}

export function generateCapnpID() {
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

export function deactivate() {}
