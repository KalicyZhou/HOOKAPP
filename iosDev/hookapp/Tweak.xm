%hook FirstViewController

- (void)buttonClick:(id)sender
{
UIAlertController *alerView = [UIAlertController alertControllerWithTitle:@"提示"
message:@"已经被HOOK了"
preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消"
style:UIAlertActionStyleCancel
handler:nil];
[alerView addAction:cancelAction];
[self presentViewController:alerView animated:YES completion:nil];
}
%end
