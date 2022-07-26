class History {
  final int? world;
  final String? question;
  final String? result;
  final bool? reseted;

  History({
    this.world = 0,
    this.question = "",
    this.result = "",
    this.reseted = false,
  });

  toHash() {
    return  {
      "world": this.world,
      "question": setQuestion(),
      "result": this.result,
      "reseted": this.reseted
    };
  }

  setQuestion() {
    if (this.question == null) {
      return null;
    }

    return "${this.question?.substring(0, question?.indexOf("?"))}?";
  }
}

