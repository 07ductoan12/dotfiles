return {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = "InsertEnter",
    dependencies = {
        {
            "ms-jpq/coq.artifacts",
            branch = "artifacts",
        },
        {
            "ms-jpq/coq.thirdparty",
            branch = "3p",
        },
    },
}
