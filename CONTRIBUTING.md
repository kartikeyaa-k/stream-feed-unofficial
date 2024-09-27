# Contributing to Stream Feed Unofficial

Thank you for considering contributing to Stream Feed Unofficial! I appreciate your efforts in helping me maintain and improve the package. This document outlines the guidelines and procedures for contributing to the project.

## Pre-Commit Hook

I have set up a pre-commit hook to maintain code quality and consistency. The pre-commit hook runs the following checks automatically before any commit:

1. **Branch Naming Check**: Ensures your branch name follows the required naming convention:  
   - Format: `feat/sfu-000-add-comment-feature`  
   - Allowed prefixes: `feat`, `bugfix`, `raise`, `merge`, `release`
   - sfu stands for stream feed unofficial, soon will have a jira board to track project properly
   
2. **Dart Formatter**: Runs `dart format` to ensure the code adheres to Dart's formatting rules.

3. **Dart Analyzer**: Runs `dart analyze` to check for any warnings, hints, or errors. **I am particular that there should be no dart analyze warnings or hints**. Refer to the lint rules in the `analysis_options.yaml` file, and we can add more rules over time.

4. **Tests**: Runs the tests to ensure all functionality works as expected and nothing is broken.

![Pre-Commit Hook Output](https://path-to-image-from-your-upload.png)  
*Example of pre-commit hook output showing all checks passed.*

## Pull Request Template

I am working on adding a standardized pull request template soon. This template will guide you through the information required for submitting changes, ensuring all necessary steps and checks are completed.

## Coding Standards

Please adhere to the following coding standards while contributing:

- **Code**: Let's make sure the code is testable, scalabale and follows SOLID principles.
- **No Warnings or Hints**: Ensure that your code passes `dart analyze` without any warnings or hints. Maintaining a clean codebase is a top priority.
- **Follow Lint Rules**: Refer to the lint rules specified in the `analysis_options.yaml` file. I encourage contributors to follow these rules strictly. I may update and add more rules as needed.
- **Formatting**: Ensure that all code is formatted using `dart format`. This is automatically checked by the pre-commit hook.


## Branch Naming

Please follow the branch naming convention strictly. Branch names should be in the format: `prefix/sfu-000-description`. Here are the accepted prefixes:
- `feat`: For new features.
- `bugfix`: For bug fixes.
- `raise`: For raising issues or updates.
- `merge`: For merge branches.
- `release`: For release-specific work.

## Getting Started

1. Fork the repository and create your branch from `main`.
2. Ensure all pre-commit hooks pass successfully.
3. Submit a pull request with a clear description of the changes made.

## Additional Information

- **Testing**: Always write tests for new features and bug fixes to maintain code quality.
- **Code Reviews**: All pull requests will be reviewed by maintainers. Ensure your code is clean and follows the guidelines before submitting.

I value your contributions and look forward to your help in improving Stream Feed Unofficial. Happy coding!

---

For any questions or further clarifications, please reach out via the issue tracker or contact the maintainers directly.

