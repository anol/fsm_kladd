package pack1;

import javax.swing.*;


public class FirstForm {
    private JButton button1;
    private JTextPane textPane1;
    private JEditorPane editorPane1;
    private JTextField textField1;
    private JFormattedTextField formattedTextField1;
    private JButton button2;
    private JRadioButton radioButton1;
    private JRadioButton radioButton2;

    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
            }
        });
    }

    private static void createAndShowGUI() {
        JFrame frame = new JFrame("JMSUtilForm");
        frame.setContentPane(new FirstForm().textPane1);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
