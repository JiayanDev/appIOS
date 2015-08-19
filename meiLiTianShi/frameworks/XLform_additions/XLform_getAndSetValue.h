#define setValue(tagV,valueV)     [self.form formRowWithTag:tagV].value=valueV;
#define getValue(k) [self.form formRowWithTag:k].value
#define getValueS(k) ((NSString*)getValue(k))