module Plugin

import Clafer;
import ParseTree;
import util::IDE;

public void main() {
  registerLanguage("Clafer", "cfr", Tree(str src, loc l) {
     return parse(#start[Module], src, l);
  });
}