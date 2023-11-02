return {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = { "BufReadPre", "BufNewFile" },
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
